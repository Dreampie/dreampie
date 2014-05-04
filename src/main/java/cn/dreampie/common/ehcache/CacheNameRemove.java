package cn.dreampie.common.ehcache;

import java.lang.annotation.*;

/**
 * Created by wangrenhui on 14-4-18.
 */
@Inherited
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE, ElementType.METHOD})
public @interface CacheNameRemove {
    String name();

    String[] keys() default {};
}

