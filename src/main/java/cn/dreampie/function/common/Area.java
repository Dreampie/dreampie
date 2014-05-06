package cn.dreampie.function.common;

import cn.dreampie.common.kit.sqlinxml.SqlKit;
import cn.dreampie.common.utils.tree.TreeNode;
import com.google.common.collect.Lists;
import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

import java.util.List;

/**
 * Created by wangrenhui on 14-4-17.
 */
@TableBind(tableName = "com_area")
public class Area extends Model<Area> implements TreeNode<Area> {
  public static Area dao = new Area();

  private List<Area> children = Lists.newArrayList();

  @Override
  public long getId() {
    return new Long(this.getInt("id"));
  }

  @Override
  public long getParentId() {
    return new Long(this.getInt("pid"));
  }

  @Override
  public List<Area> getChildren() {
    return this.get("children");
  }

  @Override
  public void setChildren(List<Area> children) {
    this.put("children", children);
  }

  public List<Area> findBy(String where, Object... paras) {
    List<Area> result = dao.find(SqlKit.sql("area.findBy") + " " + where, paras);
    return result;
  }

  public Page<Area> findBy(int pageNumber, int pageSize, String where, Object... paras) {
    Page<Area> result = dao.paginate(pageNumber, pageSize, SqlKit.sql("area.findBySelect"), SqlKit.sql("area.findByExceptSelect") + " " + where, paras);
    return result;
  }
}