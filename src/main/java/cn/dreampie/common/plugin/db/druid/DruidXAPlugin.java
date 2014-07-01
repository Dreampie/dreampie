package cn.dreampie.common.plugin.db.druid;

import cn.dreampie.common.plugin.db.tx.XAXid;
import com.alibaba.druid.filter.Filter;
import com.alibaba.druid.pool.xa.DruidXADataSource;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.IPlugin;
import com.jfinal.plugin.activerecord.IDataSourceProvider;

import javax.sql.DataSource;
import javax.sql.XAConnection;
import javax.transaction.xa.XAException;
import javax.transaction.xa.XAResource;
import javax.transaction.xa.Xid;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by wangrenhui on 2014/5/9.
 */
public class DruidXAPlugin implements IPlugin, IDataSourceProvider {

    // 基本属性 url、user、password
    private String url;
    private String username;
    private String password;
    private String driverClass = "com.mysql.jdbc.Driver";

    // 初始连接池大小、最小空闲连接数、最大活跃连接数
    private int initialSize = 10;
    private int minIdle = 10;
    private int maxActive = 100;

    // 配置获取连接等待超时的时间
    private long maxWait = DruidXADataSource.DEFAULT_MAX_WAIT;

    // 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒
    private long timeBetweenEvictionRunsMillis = DruidXADataSource.DEFAULT_TIME_BETWEEN_EVICTION_RUNS_MILLIS;
    // 配置连接在池中最小生存的时间
    private long minEvictableIdleTimeMillis = DruidXADataSource.DEFAULT_MIN_EVICTABLE_IDLE_TIME_MILLIS;
    // 配置发生错误时多久重连
    private long timeBetweenConnectErrorMillis = DruidXADataSource.DEFAULT_TIME_BETWEEN_CONNECT_ERROR_MILLIS;

    /**
     * hsqldb - "select 1 from INFORMATION_SCHEMA.SYSTEM_USERS"
     * Oracle - "select 1 from dual"
     * DB2 - "select 1 from sysibm.sysdummy1"
     * mysql - "select 1"
     */
    private String validationQuery = "select 1";
    private boolean testWhileIdle = true;
    private boolean testOnBorrow = false;
    private boolean testOnReturn = false;

    // 是否打开连接泄露自动检测
    private boolean removeAbandoned = false;
    // 连接长时间没有使用，被认为发生泄露时长
    private long removeAbandonedTimeoutMillis = 300 * 1000;
    // 发生泄露时是否需要输出 log，建议在开启连接泄露检测时开启，方便排错
    private boolean logAbandoned = false;

    // 是否缓存preparedStatement，即PSCache，对支持游标的数据库性能提升巨大，如 oracle、mysql 5.5 及以上版本
    // private boolean poolPreparedStatements = false;	// oracle、mysql 5.5 及以上版本建议为 true;

    // 只要maxPoolPreparedStatementPerConnectionSize>0,poolPreparedStatements就会被自动设定为true，使用oracle时可以设定此值。
    private int maxPoolPreparedStatementPerConnectionSize = -1;

    // 配置监控统计拦截的filters
    private String filters;    // 监控统计："stat"    防SQL注入："wall"     组合使用： "stat,wall"
    private List<Filter> filterList;

    private DruidXADataSource ds;

    public DruidXAPlugin(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }

    public DruidXAPlugin(String url, String username, String password, String driverClass) {
        this.url = url;
        this.username = username;
        this.password = password;
        this.driverClass = driverClass;
    }

    public DruidXAPlugin(String url, String username, String password, String driverClass, String filters) {
        this.url = url;
        this.username = username;
        this.password = password;
        this.driverClass = driverClass;
        this.filters = filters;
    }

    /**
     * 设置过滤器，如果要开启监控统计需要使用此方法或在构造方法中进行设置
     * <p>
     * 监控统计："stat"
     * 防SQL注入："wall"
     * 组合使用： "stat,wall"
     * </p>
     */
    public DruidXAPlugin setFilters(String filters) {
        this.filters = filters;
        return this;
    }

    public synchronized DruidXAPlugin addFilter(Filter filter) {
        if (filterList == null)
            filterList = new ArrayList<Filter>();
        filterList.add(filter);
        return this;
    }

    public boolean start() {
        ds = new DruidXADataSource();
        ds.setUrl(url);
        ds.setUsername(username);
        ds.setPassword(password);
        ds.setDriverClassName(driverClass);
        ds.setInitialSize(initialSize);
        ds.setMinIdle(minIdle);
        ds.setMaxActive(maxActive);
        ds.setMaxWait(maxWait);
        ds.setTimeBetweenConnectErrorMillis(timeBetweenConnectErrorMillis);
        ds.setTimeBetweenEvictionRunsMillis(timeBetweenEvictionRunsMillis);
        ds.setMinEvictableIdleTimeMillis(minEvictableIdleTimeMillis);

        ds.setValidationQuery(validationQuery);
        ds.setTestWhileIdle(testWhileIdle);
        ds.setTestOnBorrow(testOnBorrow);
        ds.setTestOnReturn(testOnReturn);

        ds.setRemoveAbandoned(removeAbandoned);
        ds.setRemoveAbandonedTimeoutMillis(removeAbandonedTimeoutMillis);
        ds.setLogAbandoned(logAbandoned);

        //只要maxPoolPreparedStatementPerConnectionSize>0,poolPreparedStatements就会被自动设定为true，参照druid的源码
        ds.setMaxPoolPreparedStatementPerConnectionSize(maxPoolPreparedStatementPerConnectionSize);

        if (StrKit.notBlank(filters))
            try {
                ds.setFilters(filters);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        addFilterList(ds);
        return true;
    }

    private void addFilterList(DruidXADataSource ds) {
        if (filterList != null) {
            List<Filter> targetList = ds.getProxyFilters();
            for (Filter add : filterList) {
                boolean found = false;
                for (Filter target : targetList) {
                    if (add.getClass().equals(target.getClass())) {
                        found = true;
                        break;
                    }
                }
                if (!found)
                    targetList.add(add);
            }
        }
    }

    public boolean stop() {
        if (ds != null)
            ds.close();
        return true;
    }

    public DataSource getDataSource() {
        return ds;
    }

    public DruidXAPlugin set(int initialSize, int minIdle, int maxActive) {
        this.initialSize = initialSize;
        this.minIdle = minIdle;
        this.maxActive = maxActive;
        return this;
    }

    public DruidXAPlugin setDriverClass(String driverClass) {
        this.driverClass = driverClass;
        return this;
    }

    public DruidXAPlugin setInitialSize(int initialSize) {
        this.initialSize = initialSize;
        return this;
    }

    public DruidXAPlugin setMinIdle(int minIdle) {
        this.minIdle = minIdle;
        return this;
    }

    public DruidXAPlugin setMaxActive(int maxActive) {
        this.maxActive = maxActive;
        return this;
    }

    public DruidXAPlugin setMaxWait(long maxWait) {
        this.maxWait = maxWait;
        return this;
    }

    public DruidXAPlugin setTimeBetweenEvictionRunsMillis(long timeBetweenEvictionRunsMillis) {
        this.timeBetweenEvictionRunsMillis = timeBetweenEvictionRunsMillis;
        return this;
    }

    public DruidXAPlugin setMinEvictableIdleTimeMillis(long minEvictableIdleTimeMillis) {
        this.minEvictableIdleTimeMillis = minEvictableIdleTimeMillis;
        return this;
    }

    /**
     * hsqldb - "select 1 from INFORMATION_SCHEMA.SYSTEM_USERS"
     * Oracle - "select 1 from dual"
     * DB2 - "select 1 from sysibm.sysdummy1"
     * mysql - "select 1"
     */
    public DruidXAPlugin setValidationQuery(String validationQuery) {
        this.validationQuery = validationQuery;
        return this;
    }

    public DruidXAPlugin setTestWhileIdle(boolean testWhileIdle) {
        this.testWhileIdle = testWhileIdle;
        return this;
    }

    public DruidXAPlugin setTestOnBorrow(boolean testOnBorrow) {
        this.testOnBorrow = testOnBorrow;
        return this;
    }

    public DruidXAPlugin setTestOnReturn(boolean testOnReturn) {
        this.testOnReturn = testOnReturn;
        return this;
    }

    public DruidXAPlugin setMaxPoolPreparedStatementPerConnectionSize(int maxPoolPreparedStatementPerConnectionSize) {
        this.maxPoolPreparedStatementPerConnectionSize = maxPoolPreparedStatementPerConnectionSize;
        return this;
    }

    public final void setTimeBetweenConnectErrorMillis(long timeBetweenConnectErrorMillis) {
        this.timeBetweenConnectErrorMillis = timeBetweenConnectErrorMillis;
    }

    public final void setRemoveAbandoned(boolean removeAbandoned) {
        this.removeAbandoned = removeAbandoned;
    }

    public final void setRemoveAbandonedTimeoutMillis(long removeAbandonedTimeoutMillis) {
        this.removeAbandonedTimeoutMillis = removeAbandonedTimeoutMillis;
    }

    public final void setLogAbandoned(boolean logAbandoned) {
        this.logAbandoned = logAbandoned;
    }

    private static DruidXADataSource getDruidXADataSource(String url, String username, String password) {
        DruidXAPlugin plugin = new DruidXAPlugin(url, username, password);
        DruidXADataSource ds = new DruidXADataSource();
        ds.setUrl(plugin.url);
        ds.setUsername(plugin.username);
        ds.setPassword(plugin.password);
        ds.setDriverClassName(plugin.driverClass);
        ds.setInitialSize(plugin.initialSize);
        ds.setMinIdle(plugin.minIdle);
        ds.setMaxActive(plugin.maxActive);
        ds.setMaxWait(plugin.maxWait);
        ds.setTimeBetweenConnectErrorMillis(plugin.timeBetweenConnectErrorMillis);
        ds.setTimeBetweenEvictionRunsMillis(plugin.timeBetweenEvictionRunsMillis);
        ds.setMinEvictableIdleTimeMillis(plugin.minEvictableIdleTimeMillis);

        ds.setValidationQuery(plugin.validationQuery);
        ds.setTestWhileIdle(plugin.testWhileIdle);
        ds.setTestOnBorrow(plugin.testOnBorrow);
        ds.setTestOnReturn(plugin.testOnReturn);

        ds.setRemoveAbandoned(plugin.removeAbandoned);
        ds.setRemoveAbandonedTimeoutMillis(plugin.removeAbandonedTimeoutMillis);
        ds.setLogAbandoned(plugin.logAbandoned);

        //只要maxPoolPreparedStatementPerConnectionSize>0,poolPreparedStatements就会被自动设定为true，参照druid的源码
        ds.setMaxPoolPreparedStatementPerConnectionSize(plugin.maxPoolPreparedStatementPerConnectionSize);

        if (StrKit.notBlank(plugin.filters))
            try {
                ds.setFilters(plugin.filters);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        plugin.addFilterList(ds);
        return ds;
    }


    public static void main(String[] args) throws SQLException {
        //数据库表需要时innodb类型才支持分布式事务
        DruidXADataSource ds1 = getDruidXADataSource("jdbc:mysql://192.168.1.211/sm_card?useUnicode=true&characterEncoding=UTF-8", "dev", "dev1010");
        DruidXADataSource ds2 = getDruidXADataSource("jdbc:mysql://192.168.1.211/sm_shop_master?useUnicode=true&characterEncoding=UTF-8", "dev", "dev1010");
        boolean result = true;

        XAConnection xaConnection1 = ds1.getXAConnection();
        Connection connection1 = xaConnection1.getConnection();
        //用事务，必须设置setAutoCommit false，表示手动提交
        connection1.setAutoCommit(false);
        //设置事务的隔离级别。
        connection1.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
        XAResource xaResource1 = xaConnection1.getXAResource();
        Xid xid1 = XAXid.uniqueXid(1);


        XAConnection xaConnection2 = ds2.getXAConnection();
        Connection connection2 = xaConnection2.getConnection();
        //用事务，必须设置setAutoCommit false，表示手动提交
        connection2.setAutoCommit(false);
        //设置事务的隔离级别。
        connection2.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
        XAResource xaResource2 = xaConnection2.getXAResource();
        Xid xid2 = XAXid.uniqueXid(1);
        int result1 = -1;
        int result2 = -1;
        try {


            xaResource1.setTransactionTimeout(0);
            xaResource1.start(xid1, XAResource.TMNOFLAGS);

            try {
                Statement stmt1 = connection1.createStatement();
                stmt1.executeUpdate("UPDATE fun_card SET state=0 WHERE id=30000;");

                // Commit the transaction.
                xaResource1.end(xid1, XAResource.TMSUCCESS);
            } catch (SQLException e) {
                e.printStackTrace();
                xaResource1.end(xid1, XAResource.TMFAIL);
                result = result && false;
            }
            result1 = xaResource1.prepare(xid1);

            xaResource2.setTransactionTimeout(0);
            xaResource2.start(xid2, XAResource.TMNOFLAGS);
            try {
                Statement stmt2 = connection2.createStatement();
                stmt2.executeUpdate("UPDATE com_account_card SET use_count=0  WHERE id=107;");
                // Commit the transaction.
                xaResource2.end(xid2, XAResource.TMSUCCESS);
            } catch (SQLException e) {
                e.printStackTrace();
                xaResource2.end(xid2, XAResource.TMFAIL);
                result = result && false;
            }

            result2 = xaResource2.prepare(xid2);
            if (result1 == XAResource.XA_OK && result2 == XAResource.XA_OK) {
                result = result && true;
            }

        } catch (XAException e) {
            e.printStackTrace();
            result = result && false;
        } finally {
            try {
                if (result) {
                    xaResource1.commit(xid1, false);
                    xaResource2.commit(xid2, false);
                } else {
                    if (result1 == XAResource.XA_OK)
                        xaResource1.rollback(xid1);

                    if (result2 == XAResource.XA_OK)
                        xaResource2.rollback(xid2);
                }

                // Cleanup.
                connection1.close();
                xaConnection1.close();
                connection2.close();
                xaConnection2.close();
            } catch (XAException e) {
                e.printStackTrace();
            }

        }
    }
}
