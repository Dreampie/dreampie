/**
 * Copyright (c) 2011-2013, kidzhou 周磊 (zhouleib1412@gmail.com)
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
package cn.dreampie.common.plugin.sqlinxml;

import com.jfinal.ext.kit.JaxbKit;
import com.jfinal.log.Logger;

import java.io.File;
import java.io.FileFilter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SqlKit {

  protected static final Logger LOG = Logger.getLogger(SqlKit.class);

  private static Map<String, String> sqlMap;

  public static String sql(String groupNameAndsqlId) {
    if (sqlMap == null) {
      throw new NullPointerException("SqlInXmlPlugin not start");
    }
    return sqlMap.get(groupNameAndsqlId);
  }

  static void clearSqlMap() {
    sqlMap.clear();
  }

  static void init() {
    sqlMap = new HashMap<String, String>();
    //加载sql文件
    loadFileList(SqlKit.class.getClassLoader().getResource("").getFile());
    LOG.debug("sqlMap" + sqlMap);
  }

  public static void loadFileList(String strPath) {
    List<File> files = new ArrayList<File>();
    File dir = new File(strPath);
    File[] dirs = dir.listFiles(new FileFilter() {
      @Override
      public boolean accept(File pathname) {
        if (pathname.getName().endsWith("sql") || pathname.getName().endsWith("sql.xml")) {
          return true;
        }
        return false;
      }
    });

    if (dirs == null)
      return;
    for (int i = 0; i < dirs.length; i++) {
      if (dirs[i].isDirectory()) {
        loadFileList(dirs[i].getAbsolutePath());
      } else {
        if (dirs[i].getName().endsWith("sql.xml")) {
          files.add(dirs[i]);
        }
      }
    }
    //加载sql文件
    loadFiles(files);
  }

  /**
   * 加载xml文件
   *
   * @param files
   */
  private static void loadFiles(List<File> files) {
    for (File xmlfile : files) {
      SqlRoot root = JaxbKit.unmarshal(xmlfile, SqlRoot.class);
      for (SqlGroup sqlGroup : root.sqlGroups) {

        String name = sqlGroup.name;
        if (name == null || name.trim().equals("")) {
          name = xmlfile.getName();
        }
        for (SqlItem sqlItem : sqlGroup.sqlItems) {
          sqlMap.put(name + "." + sqlItem.id, sqlItem.value);
        }
      }
    }
  }
}
