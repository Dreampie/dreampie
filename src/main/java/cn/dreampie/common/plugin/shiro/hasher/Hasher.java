/**
 * @create_time 2013-1-7 上午11:12:33
 * @create_user wangrenhui
 * @whattodo
 * @modify_time like:date1/date2
 * @modify_user like:user1/user2
 * @modify_content like:content1/content2
 */
package cn.dreampie.common.plugin.shiro.hasher;

/**
 * @author wangrenhui
 * @description 对象类型枚举
 * @create_time 2013-1-7 下午12:36:49
 */
public enum Hasher {
    DEFAULT("default_hasher");

    private final String value;

    private Hasher(String value) {
        this.value = value;
    }

    public String value() {
        return this.value;
    }
}
