package cn.dreampie.common.plugin.shiro.plugin;

import java.util.Map;

/**
 * Created by wangrenhui on 14-1-7.
 */
public interface JdbcAuthzService {
    public Map<String, AuthzHandler> getJdbcAuthz();
}
