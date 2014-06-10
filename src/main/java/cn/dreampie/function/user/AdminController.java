package cn.dreampie.function.user;

import cn.dreampie.common.config.AppConstants;
import cn.dreampie.common.web.controller.Controller;
import cn.dreampie.common.ehcache.CacheNameRemove;
import cn.dreampie.common.utils.ValidateUtils;
import cn.dreampie.common.utils.tree.TreeUtils;
import com.google.common.collect.Lists;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.jfinal.plugin.ehcache.CacheName;

import java.util.Date;
import java.util.List;

/**
 * Created by wangrenhui on 14-1-3.
 */
public class AdminController extends Controller {
    public void index() {
        dynaRender("/page/admin/index.ftl");
    }

    @CacheName(AppConstants.DEFAULT_CACHENAME)
    public void role() {
        List<Role> roles = Role.dao.findBy("`role`.deleted_at is NULL");
        if (!ValidateUtils.me().isNullOrEmpty(roles))
            setAttr("role", roles.get(0));

        List<Permission> authories = Permission.dao.findBy("`permission`.deleted_at is NULL");
        setAttr("rolestree", TreeUtils.toTree(roles));
        setAttr("permissionestree", TreeUtils.toTreeLevel(authories, 2));

        dynaRender("/page/admin/role.ftl");
    }

    @CacheName(AppConstants.DEFAULT_CACHENAME)
    public void permIds() {
        Integer roleId = getParaToInt("role.id");
        if (roleId > 0) {
            List<String> permIds = RolePermission.dao.findPermissionIds("`rolePermission`.role_id=" + roleId);
            setAttr("permIds", permIds);
        }
        dynaRender("/page/admin/role.ftl");
    }

    @CacheNameRemove(name = AppConstants.DEFAULT_CACHENAME)
    @Before({AdminValidator.RoleSaveValidator.class, Tx.class})
    public void saveRole() {
        Role role = getModel(Role.class);
        Role parent = null;
        if (role.getParentId() == 0) {
            parent = Role.dao.findByFirst("`role`.pid=0 ORDER BY `role`.right_code DESC");
        } else
            parent = Role.dao.findById(role.getParentId());
        boolean result = false;
        if (!ValidateUtils.me().isNullOrEmpty(parent)) {
            Role.dao.updateBy("`role`.left_code=`role`.left_code+2", "`role`.left_code>=" + parent.get("right_code"));
            Role.dao.updateBy("`role`.right_code=`role`.right_code+2", "`role`.right_code>=" + parent.get("right_code"));
            role.set("left_code", parent.getLong("right_code"));
            role.set("right_code", parent.getLong("right_code") + 1);
            role.set("created_at", new Date());
            if (ValidateUtils.me().isNullOrEmpty(role.get("id"))) {
                role.remove("id");
            }
            result = role.save();
        }

        if (result) {
            setAttr("state", "success");
        } else {
            setAttr("state", "failure");
        }
        dynaRender("/page/admin/role.ftl");
    }

    @CacheNameRemove(name = AppConstants.DEFAULT_CACHENAME)
    @Before({AdminValidator.RoleUpdateValidator.class, Tx.class})
    public void updateRole() {
        Role role = getModel(Role.class);
        if (ValidateUtils.me().isNullOrEmpty(role.get("pid"))) {
            role.remove("pid");
        }
        role.set("updated_at", new Date());
        if (role.update()) {
            setAttr("state", "success");
        } else {
            setAttr("state", "failure");
        }
        dynaRender("/page/admin/role.ftl");
    }

    @CacheNameRemove(name = AppConstants.DEFAULT_CACHENAME)
    @Before({AdminValidator.RoleDeleteValidator.class, Tx.class})
    public void dropRole() {

        Integer id = getParaToInt("role.id");
        Role role = Role.dao.findById(id);
        boolean result = false;
        if (!ValidateUtils.me().isNullOrEmpty(role)) {
            Role.dao.updateBy("`role`.left_code=`role`.left_code-2", "`role`.left_code>=" + role.get("left_code"));
            Role.dao.updateBy("`role`.right_code=`role`.right_code-2", "`role`.right_code>=" + role.get("right_code"));

            result = role.delete();
            if (result) {
                RolePermission.dao.deleteBy("role_id=" + role.get("id"));
            }
        }

        if (result) {
            setAttr("state", "success");
        } else {
            setAttr("state", "failure");
        }
        dynaRender("/page/admin/role.ftl");
    }

    @CacheNameRemove(name = AppConstants.DEFAULT_CACHENAME)
    @Before({AdminValidator.PermSaveValidator.class, Tx.class})
    public void savePerm() {
        Permission permission = getModel(Permission.class);
        Permission parent = null;
        if (permission.getParentId() == 0) {
            parent = Permission.dao.findByFirst("`permission`.pid=0 ORDER BY `permission`.right_code DESC");
        } else
            parent = Permission.dao.findById(permission.getParentId());
        boolean result = false;
        if (!ValidateUtils.me().isNullOrEmpty(parent)) {
            Permission.dao.updateBy("`permission`.left_code=`permission`.left_code+2", "`permission`.left_code>=" + parent.get("right_code"));
            Permission.dao.updateBy("`permission`.right_code=`permission`.right_code+2", "`permission`.right_code>=" + parent.get("right_code"));
            permission.set("left_code", parent.getLong("right_code"));
            permission.set("right_code", parent.getLong("right_code") + 1);
            permission.set("created_at", new Date());
            if (ValidateUtils.me().isNullOrEmpty(permission.get("id"))) {
                permission.remove("id");
            }
            result = permission.save();
        }
        if (result) {
            Role admin = Role.dao.findByFirst("`role`.pid=0");
            admin.addPermission(permission);
            setAttr("state", "success");
        } else {
            setAttr("state", "failure");
        }
        dynaRender("/page/admin/role.ftl");
    }

    @CacheNameRemove(name = AppConstants.DEFAULT_CACHENAME)
    @Before({AdminValidator.PermUpdateValidator.class, Tx.class})
    public void updatePerm() {
        Permission permission = getModel(Permission.class);
        if (ValidateUtils.me().isNullOrEmpty(permission.get("pid"))) {
            permission.remove("pid");
        }
        permission.set("updated_at", new Date());
        if (permission.update()) {
            setAttr("state", "success");
        } else {
            setAttr("state", "failure");
        }
        dynaRender("/page/admin/role.ftl");
    }

    @CacheNameRemove(name = AppConstants.DEFAULT_CACHENAME)
    @Before({AdminValidator.PermDeleteValidator.class, Tx.class})
    public void dropPerm() {

        Integer id = getParaToInt("permission.id");
        Permission permission = Permission.dao.findById(id);
        boolean result = false;
        if (!ValidateUtils.me().isNullOrEmpty(permission)) {
            Permission.dao.updateBy("`permission`.left_code=`permission`.left_code-2", "`permission`.left_code>=" + permission.get("left_code"));
            Permission.dao.updateBy("`permission`.right_code=`permission`.right_code-2", "`permission`.right_code>=" + permission.get("right_code"));
            result = permission.delete();
            if (result) {
                RolePermission.dao.deleteBy("permission_id=" + permission.get("id"));
            }
        }
        if (result) {
            setAttr("state", "success");
        } else {
            setAttr("state", "failure");
        }
        dynaRender("/page/admin/role.ftl");
    }

    @CacheNameRemove(name = AppConstants.DEFAULT_CACHENAME)
    @Before({AdminValidator.RolePermsValidator.class, Tx.class})
    public void addPerms() {
        String[] idsPara = getParaValues("permission.id");
        Integer roleId = getParaToInt("role.id");
        //需要添加的权限
        List<String> ids = Lists.newArrayList(idsPara);
        //已存在的权限
        List<String> permIds = RolePermission.dao.findPermissionIds("`rolePermission`.role_id=" + roleId);
        Integer id = null;
        //移除重复id
        for (int i = 0; i < ids.size(); i++) {
            id = new Integer(ids.get(i));
            if (permIds.contains(id)) {
                permIds.remove(id);
                ids.remove(i);
                i--;
            }
        }
        boolean result = true;
        //添加关系
        RolePermission rolePermission = null;
        for (int i = 0; i < ids.size(); i++) {
            rolePermission = new RolePermission();
            rolePermission.set("role_id", roleId);
            rolePermission.set("permission_id", ids.get(i));
            result = result && rolePermission.save();
        }
        //删除关系

        for (int i = 0; i < permIds.size(); i++) {
            result = result && RolePermission.dao.deleteBy("role_id = ? AND permission_id = ?", roleId, permIds.get(i));
        }
        if (result) {
            setAttr("state", "success");
        } else {
            setAttr("state", "failure");
        }
        dynaRender("/page/admin/role.ftl");
    }
}
