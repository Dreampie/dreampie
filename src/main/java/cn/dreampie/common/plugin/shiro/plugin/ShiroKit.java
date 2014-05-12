/**
 * Copyright (c) 2011-2013, dafei 李飞 (myaniu AT gmail DOT com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package cn.dreampie.common.plugin.shiro.plugin;

import org.apache.shiro.util.AntPathMatcher;
import org.apache.shiro.web.util.WebUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentMap;

/**
 * ShiroKit. (Singleton, ThreadSafe)
 *
 * @author dafei
 */
public class ShiroKit {

  /**
   * 用来记录那个action或者actionpath中是否有shiro认证注解。
   */
  private static ConcurrentMap<String, AuthzHandler> authzMaps = null;

  private static Map<String, AuthzHandler> authzJdbcMaps = null;

  public static AntPathMatcher antPathMatcher = new AntPathMatcher();

  /**
   * 禁止初始化
   */
  private ShiroKit() {
  }

  static void init(ConcurrentMap<String, AuthzHandler> amaps, Map<String, AuthzHandler> jmaps) {
    authzMaps = amaps;
    authzJdbcMaps = jmaps;
  }


  static AuthzHandler getAuthzHandler(String actionKey) {
    /*
    if(authzMaps.containsKey(controllerClassName)){
			return true;
		}*/
    return authzMaps.get(actionKey);
  }

  static List<AuthzHandler> getJdbcAuthzHandler(HttpServletRequest request) {
    /*
    if(authzMaps.containsKey(controllerClassName)){
			return true;
		}*/
    List<AuthzHandler> result = new ArrayList<AuthzHandler>();
    String url = WebUtils.getPathWithinApplication(request);
    for (String key : authzJdbcMaps.keySet()) {
      if (antPathMatcher.match(key, url)) {
        result.add(authzJdbcMaps.get(key));
      }
    }
    return result;
  }

  static List<AuthzHandler> getAuthzHandler(HttpServletRequest request, String actionKey) {
    List<AuthzHandler> result = getJdbcAuthzHandler(request);
    AuthzHandler ah = getAuthzHandler(actionKey);
    if (ah != null) {
      result.add(ah);
    }
    return result;
  }
}
