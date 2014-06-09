package cn.dreampie.common.plugin.db;

import cn.dreampie.common.utils.FileUtils;
import cn.dreampie.common.utils.PropertiesUtils;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import com.jfinal.kit.PathKit;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.*;

/**
 * Created by wangrenhui on 14-5-5.
 */
public class DbConfig {
    private Logger logger = LoggerFactory.getLogger(getClass());

    private String config = "/application.properties";
    private Properties properties;

    public DbConfig() {
        properties = PropertiesUtils.me().loadPropertyFile(config);
    }

    public DbConfig(String config) {
        this.config = config;
        properties = PropertiesUtils.me().loadPropertyFile(config);
    }

    public List<String> getAllDbNames() {
        Set<String> dbNames = Sets.newHashSet();
        Enumeration enums = properties.keys();
        String key = null;
        String dbName = null;
        while (enums.hasMoreElements()) {
            key = enums.nextElement() + "";
            if (key.startsWith("db.")) {
                dbName = key.split("\\.")[1];
                dbNames.add(dbName);
            }
        }
        return new ArrayList<String>(dbNames);
    }

    public Map<String, DbSource> getAllDbSources() {
        Map<String, DbSource> dbSourceMap = Maps.newHashMap();
        List<String> dbNames = getAllDbNames();
        for (String dbName : dbNames) {
            dbSourceMap.put(dbName, new DbSource(properties.getProperty("db." + dbName + ".driver"), properties.getProperty("db." + dbName + ".url"), properties.getProperty("db." + dbName + ".user"), properties.getProperty("db." + dbName + ".password")));
        }
        return dbSourceMap;
    }


    public boolean initOnMigrate(String dbName) {
        return properties.getProperty("db." + dbName + ".migration.initOnMigrate", "false").equals("true");
    }

    public boolean migrateAuto(String dbName) {
        return properties.getProperty("db." + dbName + ".migration.auto", "false").equals("true");
    }

    public boolean migrationFileDirectoryExists(String path) {
        if (FileUtils.me().exist(PathKit.getRootClassPath() + path)) {
            logger.debug("Directory for migration files found." + path);
            return true;
        } else {
            logger.warn("Directory for migration files not found." + path);
            return false;
        }
    }

    public boolean isClean(String dbName) {
        return PropertiesUtils.me().loadPropertyFile(config).getProperty("db." + dbName + ".valid.clean", "false").equals("true");
    }

    public boolean isDev() {
        return PropertiesUtils.me().loadPropertyFile(config).getProperty("devMode", "false").equals("true");
    }
}
