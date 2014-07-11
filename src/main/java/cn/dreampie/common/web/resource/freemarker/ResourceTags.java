package cn.dreampie.common.web.resource.freemarker;

import freemarker.template.SimpleHash;

/**
 * Created by wangrenhui on 14-4-10.
 */
public class ResourceTags extends SimpleHash {
    public ResourceTags() {
        put("static", new StaticTag());
    }
}
