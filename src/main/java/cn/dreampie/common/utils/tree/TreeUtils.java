package cn.dreampie.common.utils.tree;

import com.google.common.collect.Lists;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * Created by wangrenhui on 14-4-12.
 */
public class TreeUtils {

    public static List toTree(List params) {
        List nodes = null;
        if (params.size() > 0) {
            //优先级排序
            Collections.sort(params, new Comparator<TreeNode>() {
                @Override
                public int compare(TreeNode rp1, TreeNode rp2) {
                    return Long.compare(rp1.getParentId(), rp2.getParentId());
                }
            });
            nodes = toTree(params, ((TreeNode) params.get(0)).getParentId());
        }
        return nodes;
    }

    public static List toTreeLevel(List params, int level) {
        List nodes = null;
        if (params.size() > 0) {
            //优先级排序
            Collections.sort(params, new Comparator<TreeNode>() {
                @Override
                public int compare(TreeNode rp1, TreeNode rp2) {
                    return Long.compare(rp1.getParentId(), rp2.getParentId());
                }
            });
            nodes = toTreeLevel(params, ((TreeNode) params.get(0)).getParentId(), level);
        }
        return nodes;
    }

    /**
     * 无限级树形结构
     *
     * @param params
     * @param pid
     * @return
     */
    public static List toTree(List params, long pid) {
        List nodes = Lists.newArrayList();

        if (params != null && params.size() > 0) {

            TreeNode node = null;
            for (int i = 0; i < params.size(); i++) {
                node = (TreeNode) params.get(i);
                if (node.getParentId() == pid) {
                    nodes.add(node);
                    params.remove(i);
                    node.setChildren(toTree(params, node.getId()));
                    i--;
                }
            }
        }
        return nodes;
    }

    /**
     * 两级树形数据
     *
     * @param params
     * @param pid
     * @return
     */
    public static List toTreeLevel(List params, long pid, int level) {
        List nodes = Lists.newArrayList();

        if (params != null && params.size() > 0) {
            TreeNode node = null;//当前节点
            for (int i = 0; i < params.size(); i++) {
                node = (TreeNode) params.get(i);
                if (node.getParentId() == pid) {
                    nodes.add(node);
                    params.remove(i);
                    if (level > 1) {
//                        System.out.println(node.getId() + ":" + level);
                        node.setChildren(toTreeLevel(params, node.getId(), --level));
                    } else {
//                        System.out.println(node.getId() + ":" + level + ":" + nodes.size());
                        nodes.addAll(toTreeLevel(params, node.getId(), --level));
                    }
                    level++;
                    i--;
                }
            }
        }
        return nodes;
    }
//
//    public static void main(String[] args) {
//        List params = Lists.newArrayList();
//        Channel channel = new Channel();
//        channel.setId(1);
//        channel.setParentId(0);
//        params.add(channel);
//        channel = new Channel();
//        channel.setId(2);
//        channel.setParentId(1);
//        params.add(channel);
//        channel = new Channel();
//        channel.setId(3);
//        channel.setParentId(2);
//        params.add(channel);
//        channel = new Channel();
//        channel.setId(4);
//        channel.setParentId(0);
//        params.add(channel);
//        channel = new Channel();
//        channel.setId(5);
//        channel.setParentId(1);
//        params.add(channel);
//        List res = new TreeUtils().toTree(params);
//        System.out.print(StringUtils.join(res, ","));
//    }
}
