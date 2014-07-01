package cn.dreampie.common.plugin.db.tx;

/**
 * Created by wangrenhui on 2014/5/9.
 */

import java.lang.annotation.*;

/**
 * AXTxConfig is used to configure configName for AXTx interceptor
 */
@Inherited
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE, ElementType.METHOD})
public @interface AXTxConfig {
    String[] value();        // configName of Config
}