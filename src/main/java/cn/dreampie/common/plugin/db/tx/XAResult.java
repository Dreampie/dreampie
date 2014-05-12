package cn.dreampie.common.plugin.db.tx;

import com.jfinal.plugin.activerecord.Config;

import javax.sql.XAConnection;
import javax.transaction.xa.XAResource;

/**
 * Created by wangrenhui on 2014/5/9.
 */
public class XAResult {

    Config config;
    XAResource xaResource;
    XAConnection xaConnection;
    Boolean autoCommit;
    boolean removeConnection;

    public XAResult(Config config, XAResource xaResource, XAConnection xaConnection, Boolean autoCommit, boolean removeConnection) {
        this.config = config;
        this.xaResource = xaResource;
        this.xaConnection = xaConnection;
        this.autoCommit = autoCommit;
        this.removeConnection = removeConnection;
    }

    public Config getConfig() {
        return config;
    }

    public void setConfig(Config config) {
        this.config = config;
    }

    public XAResource getXaResource() {
        return xaResource;
    }

    public void setXaResource(XAResource xaResource) {
        this.xaResource = xaResource;
    }

    public XAConnection getXaConnection() {
        return xaConnection;
    }

    public void setXaConnection(XAConnection xaConnection) {
        this.xaConnection = xaConnection;
    }

    public Boolean getAutoCommit() {
        return autoCommit;
    }

    public void setAutoCommit(Boolean autoCommit) {
        this.autoCommit = autoCommit;
    }

    public boolean isRemoveConnection() {
        return removeConnection;
    }

    public void setRemoveConnection(boolean removeConnection) {
        this.removeConnection = removeConnection;
    }
}
