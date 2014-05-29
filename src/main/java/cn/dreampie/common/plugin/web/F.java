package cn.dreampie.common.plugin.web;

/**
 * Created by wangrenhui on 2014/5/29.
 */

/**
 * Defines a set of functional programming style helpers.
 */
public class F {

    /**
     * A Callback with no arguments.
     */
    public static interface Callback0 {
        public void invoke() throws Throwable;
    }

    /**
     * A Callback with a single argument.
     */
    public static interface Callback<A> {
        public void invoke(A a) throws Throwable;
    }

    /**
     * A Callback with 2 arguments.
     */
    public static interface Callback2<A, B> {
        public void invoke(A a, B b) throws Throwable;
    }

    /**
     * A Callback with 3 arguments.
     */
    public static interface Callback3<A, B, C> {
        public void invoke(A a, B b, C c) throws Throwable;
    }

}
