package cn.dreampie.common.utils.tree;

import java.util.List;

/**
 * Created by wangrenhui on 14-4-12.
 */
public interface TreeNode<T> {

    public long getId();

    public long getParentId();

    public List<T> getChildren();

    public void setChildren(List<T> children);

}
