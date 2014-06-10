package cn.dreampie.function.common;

import cn.dreampie.common.config.AppConstants;
import com.jfinal.plugin.ehcache.CacheName;
import cn.dreampie.common.web.controller.Controller;
import cn.dreampie.common.utils.ValidateUtils;

/**
 * Created by wangrenhui on 14-1-3.
 */
public class StateController extends Controller {

    public void index() {
        dynaRender("/page/index.ftl");
    }

    @CacheName(AppConstants.DEFAULT_CACHENAME)
    public void own() {
        setAttr("states", State.dao.findBy("`state`.deleted_at is NULL"));
        dynaRender("/page/index.ftl");
    }

    @CacheName(AppConstants.DEFAULT_CACHENAME)
    public void one() {
        String type = getPara("state.type");
        String value = getPara("state.value");
        if (!ValidateUtils.me().isNullOrEmpty(type) && !ValidateUtils.me().isNullOrEmpty(value) && ValidateUtils.me().isPositiveNumber(value)) {
            setAttr("state", State.dao.findByFirst("`state`.type=? AND `state`.value=?", type, value));
        }
        dynaRender("/page/index.ftl");
    }
}
