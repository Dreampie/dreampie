package cn.dreampie.common.ehcache;

import cn.dreampie.common.utils.ValidateUtils;
import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
import com.jfinal.plugin.ehcache.CacheKit;

import java.util.List;

/**
 * Created by wangrenhui on 14-4-18.
 */
public class CacheRemoveInterceptor implements Interceptor {
    private static final String SLASH = "/";
    private static final String QMARK = "?";

    @Override
    public void intercept(ActionInvocation ai) {
        ai.invoke();
        String removeCacheName = buildRemoveCacheName(ai);
        String[] removeCacheKeys = buildRemoveCacheKeys(ai);
        String controllerKey = ai.getControllerKey();
        if (!ValidateUtils.me().isNullOrEmpty(removeCacheName)) {
            String keyPrefix = null;
            if (!ValidateUtils.me().isNullOrEmpty(removeCacheKeys)) {
                for (String removeKey : removeCacheKeys) {
                    keyPrefix = controllerKey + SLASH + removeKey;
                    removeByCacheKey(removeCacheName, keyPrefix);
                }
            } else {
                keyPrefix = controllerKey;
                removeByCacheKey(removeCacheName, keyPrefix);
            }
        }
    }

    private void removeByCacheKey(String removeCacheName, String keyPrefix) {
        List keys = CacheKit.getKeys(removeCacheName);
        String keyStr = null;
        for (Object key : keys) {
            if (!ValidateUtils.me().isNullOrEmpty(key)) {
                keyStr = key.toString();
                if ((keyStr.equals(keyPrefix) || keyStr.startsWith(keyPrefix + SLASH) || keyStr.startsWith(keyPrefix + QMARK))) {
                    CacheKit.remove(removeCacheName, key);
                }
            }
        }
    }

    private String buildRemoveCacheName(ActionInvocation ai) {
        CacheNameRemove removeCacheName = ai.getMethod().getAnnotation(CacheNameRemove.class);
        if (removeCacheName != null)
            return removeCacheName.name();

        removeCacheName = ai.getController().getClass().getAnnotation(CacheNameRemove.class);
        if (removeCacheName != null)
            return removeCacheName.name();
        return null;
    }

    private String[] buildRemoveCacheKeys(ActionInvocation ai) {
        CacheNameRemove removeCacheName = ai.getMethod().getAnnotation(CacheNameRemove.class);
        if (removeCacheName != null)
            return removeCacheName.keys();

        removeCacheName = ai.getController().getClass().getAnnotation(CacheNameRemove.class);
        if (removeCacheName != null)
            return removeCacheName.keys();
        return null;
    }
}
