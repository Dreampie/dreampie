package cn.dreampie.common.plugin.db;

import com.google.common.collect.Maps;
import com.jfinal.plugin.IPlugin;
import org.apache.commons.lang3.StringUtils;
import org.flywaydb.core.Flyway;
import org.flywaydb.core.api.MigrationInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Map;

/**
 * Created by wangrenhui on 14-4-21.
 */
public class FlywayPlugin implements IPlugin {

    private Logger logger = LoggerFactory.getLogger(getClass());

    private String flywayPrefixToMigrationScript = "/db/migration/";


    private DbConfig dbConfig;

    public FlywayPlugin() {
        dbConfig = new DbConfig();
    }

    public FlywayPlugin(String config) {
        dbConfig = new DbConfig(config);
    }


    @Override
    public boolean start() {
        List<String> dbNames = dbConfig.getAllDbNames();
        boolean dev = dbConfig.isDev();
        for (String dbName : dbNames) {
            boolean auto = dbConfig.migrateAuto(dbName);
            if (dev || auto) {
                migrateAutomatically(dbName);
            } else {
                checkState(dbName);
            }
        }
        logger.info("flyway inited!");
        return true;
    }

    @Override
    public boolean stop() {
        List<String> dbNames = dbConfig.getAllDbNames();
        for (String dbName : dbNames) {
            cleanAutomatically(dbName);
        }
        logger.info("flyway stoped!");
        return true;
    }

    private Map<String, Flyway> flyways() {
        Map<String, Flyway> flywayMap = Maps.newHashMap();
        Map<String, DbSource> dbSourceMap = dbConfig.getAllDbSources();
        DbSource dbSource = null;
        String migrationFilesLocation = null;
        Flyway flyway = null;
        for (String dbName : dbSourceMap.keySet()) {
            migrationFilesLocation = flywayPrefixToMigrationScript + dbName;
            if (dbConfig.migrationFileDirectoryExists(migrationFilesLocation)) {
                dbSource = dbSourceMap.get(dbName);
                flyway = new Flyway();
                flyway.setDataSource(dbSource.url, dbSource.user, dbSource.password);
                flyway.setLocations(migrationFilesLocation);
                if (dbConfig.isClean(dbName)) {
                    flyway.setCleanOnValidationError(true);
                }
                if (dbConfig.initOnMigrate(dbName)) {
                    flyway.setInitOnMigrate(true);
                }
                flywayMap.put(dbName, flyway);
            }
        }
        return flywayMap;
    }

    private void migrateAutomatically(String dbName) {
        Map<String, Flyway> flywayMap = flyways();
        flywayMap.get(dbName).migrate();
    }

    private void cleanAutomatically(String dbName) {
        Map<String, Flyway> flywayMap = flyways();
        flywayMap.get(dbName).clean();
    }

    private void checkState(String dbName) {
        Map<String, Flyway> flywayMap = flyways();

        MigrationInfo[] pendingMigrations = flywayMap.get(dbName).info().pending();

        if (pendingMigrations != null) {
            throw new RuntimeException(dbName + "-" + StringUtils.join(pendingMigrations, ","));
        }
    }
}
