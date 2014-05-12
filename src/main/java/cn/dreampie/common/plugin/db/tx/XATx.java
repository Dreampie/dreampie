package cn.dreampie.common.plugin.db.tx;

/**
 * Created by wangrenhui on 2014/5/9.
 */

import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
import com.jfinal.plugin.activerecord.ActiveRecordException;
import com.jfinal.plugin.activerecord.Config;
import com.jfinal.plugin.activerecord.DbKit;

import javax.sql.XAConnection;
import javax.transaction.xa.XAException;
import javax.transaction.xa.XAResource;
import javax.transaction.xa.Xid;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * ActiveRecord declare transaction.
 * Example: @Before(Tx.class)
 */
public class XATx implements Interceptor {

    static Config[] getConfigWithAXTxConfigs(ActionInvocation ai) {
        AXTxConfig axTxConfig = ai.getMethod().getAnnotation(AXTxConfig.class);
        if (axTxConfig == null)
            axTxConfig = ai.getController().getClass().getAnnotation(AXTxConfig.class);

        if (axTxConfig != null) {
            Config[] configs = null;
            String[] names = axTxConfig.value();
            if (names != null && names.length > 0) {
                int length = names.length;
                configs = new Config[length];
                int i = 0;
                for (String conf : names) {
                    configs[i] = DbKit.getConfig(conf);
                    i++;
                }
            }
            if (configs == null)
                throw new RuntimeException("Config not found with AXTxConfig");
            return configs;
        }
        return null;
    }

    protected int getTransactionLevel(Config config) {
        return config.getTransactionLevel();
    }

    static int tid = 0;

    public void intercept(ActionInvocation ai) {
        Config[] configs = getConfigWithAXTxConfigs(ai);
        XAXid xid = XAXid.uniqueXid(++tid);
        if (configs != null && configs.length > 0) {
            boolean r = true;
            XAResult[] xaResults = new XAResult[configs.length];
            int i = 0;
            for (Config c : configs) {
                //当前配置的数据源的预执行结果
                xaResults[i] = prepare(ai, c, xid);
                r = r && (xaResults[i].getXaResource() != null);
                i++;
            }
            //如果执行没有错误
            if (r) {
                Connection connection = null;
                for (XAResult xaResult : xaResults) {
                    connection = ((Connection) xaResult.getXaConnection());
                    try {
                        xaResult.getXaResource().commit(xid, false);
                    } catch (XAException xae) {
                        throw new ActiveRecordException(xae);
                    } finally {
                        try {
                            if (connection != null) {
                                if (xaResult.getAutoCommit() != null) {
                                    connection.setAutoCommit(xaResult.getAutoCommit());
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();    // can not throw exception here, otherwise the more important exception in previous catch block can not be thrown
                        } finally {
                            if (xaResult.isRemoveConnection())
                                xaResult.getConfig().removeThreadLocalConnection();    // prevent memory leak
                        }
                    }
                }
            }
        }
        tid--;
    }

    private XAResult prepare(ActionInvocation ai, Config config, Xid xid) {
        XAConnection xaConn = null;
        Connection conn = config.getThreadLocalConnection();
        if (conn != null) {    // Nested transaction support

            xaConn = (XAConnection) conn;
            try {
                if (conn.getTransactionIsolation() < getTransactionLevel(config))
                    conn.setTransactionIsolation(getTransactionLevel(config));
                //返回resource
                return new XAResult(config, prepareInvoke(xaConn, xid, ai), xaConn, null, false);
            } catch (SQLException e) {
                throw new ActiveRecordException(e);
            } catch (XAException xae) {
                throw new ActiveRecordException(xae);
            }
        }

        Boolean autoCommit = null;
        try {
            conn = config.getConnection();
            autoCommit = conn.getAutoCommit();
            config.setThreadLocalConnection(conn);
            conn.setTransactionIsolation(getTransactionLevel(config));    // conn.setTransactionIsolation(transactionLevel);
            conn.setAutoCommit(false);
            xaConn = (XAConnection) conn;
            return new XAResult(config, prepareInvoke(xaConn, xid, ai), xaConn, autoCommit, true);
        } catch (Exception e) {
            throw new ActiveRecordException(e);
        }
    }

    private XAResource prepareInvoke(XAConnection xaconn, Xid xid, ActionInvocation ai) throws SQLException, XAException {
        XAResource xaRes = xaconn.getXAResource();
        xaRes.start(xid, XAResource.TMNOFLAGS);
        //操作
        ai.invoke();
        xaRes.end(xid, XAResource.TMSUCCESS);
        int result = xaRes.prepare(xid);
        if (result == XAResource.XA_OK) {
            return xaRes;
        }
        return null;
    }
}