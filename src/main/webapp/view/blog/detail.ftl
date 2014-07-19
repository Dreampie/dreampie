<#include "/view/layout/_layout.ftl"/>
<@layout activebar="blog" html_title=i18n.getText("blog.name")>
<link rel="stylesheet" type="text/css" href="<@resource.static/>/css/app/blog/blog.css"/>
<!-- 面包屑 -->
<ol class="breadcrumb panel">
    <li><i class="fa fa-home"></i>&nbsp;<a title="Go to Home." href="/">Dreampie</a></li>
    <li><a title="Go to Blog." href="/blog">Blog</a></li>
    <li class="active">
        <#if blog??>${blog.title!}</#if></li>
</ol>
<!-- 面包屑 -->

<div class="row">
    <div class="col-md-9">
        <#if blog??>
            <article class="article col-md-12 thumbnail">
                <!-- 大型设备文章属性 -->
                <div class="hidden-xs">
                    <div class="title-article">
                        <h1><a href="/blog/detail/${blog.id}">${blog.title}</a></h1>
                    </div>
                    <div class="tag-article">
                        <span class="label label-support"><i class="fa fa-tags"></i> ${blog.created_at?string("dd-MM")}</span>
                        <#if blog.tags??>
                            <span class="label label-support"><i class="fa fa-tags"></i>
                                <#assign tags=blog.tags?split(",")>
                                <#list tags as tag>
                                    <a href="/blog/search?tags=${tag}" title="查看${tag}中的全部文章"
                                       rel="category tag">${tag}</a>
                                    <#if tag_index!=tags?size-1>
                                        ,
                                    </#if>
                                </#list>
                        </span>
                        </#if>
                        <span class="label label-support"><i class="fa fa-user"></i> <a
                                href="/user/detail/${blog.user_id}" title="由${blog.full_name}发布" rel="author">${blog.full_name}</a></span>
                        <span class="label label-support"><i class="fa fa-eye"></i> ${blog.hit_count}人</span>
                    </div>
                </div>
                <!-- 大型设备文章属性 -->
                <!-- 小型设备文章属性 -->
                <div class="visible-xs">
                    <div class="title-article">
                        <h4><a href="/blo/detail/${blog.id}">${blog.title}</a></h4>
                    </div>
                    <p>
                        <i class="fa fa-user"></i>${blog.full_name}  <i class="fa fa-calendar"></i> ${blog.created_at?string("dd-MM")} <i
                            class="fa fa-eye"></i> ${blog.hit_count}人
                    </p>
                </div>
                <!-- 小型设备文章属性 -->
                <div class="centent-article">
                    <figure class="thumbnail hidden-xs"><img width="100%" height="292"
                                                             src="http://www.yeahzan.com/zanblog/wp-content/uploads/2013/09/car_10.jpg"
                                                             class="attachment-730x300 wp-post-image" alt="Zanblog 2.0.7（稳定版）更新"
                                                             title="Zanblog 2.0.7（稳定版）更新"></figure>
                    <p>
                    ${blog.body}
                    </p>


                    <!-- 附件下载 -->
                <#--<p><a class="btn btn-danger" href="http://pan.baidu.com/s/1ntlslGP" target="_blank">完整包下载</a> <a class="btn btn-info"-->
                <#--href="http://pan.baidu.com/s/1c0GcEoK"-->
                <#--target="_blank">升级补丁包下载</a>-->
                <#--<a class="btn btn-warning" href="http://pan.baidu.com/s/1i3miMHn" target="_blank">插件包下载</a></p>-->

                    <!-- 分页 -->
                    <div clas="zan-page bs-example">
                        <ul class="pager">
                            <li class="previous"><a href="/blog/detail/${blog.id}?near=-1" rel="prev">上一篇</a></li>
                            <li class="next"><a href="/blog/detail/${blog.id}?near=1" rel="next">下一篇</a></li>
                        </ul>
                    </div>
                    <!-- 分页 -->
                    <!-- 文章版权信息 -->
                    <div class="copyright alert alert-success">
                        <p>版权属于：<a href="/user/detail/${blog.user_id}">${blog.full_name}</a> - <a
                                href="/department/detail/${blog.department_id}">${blog.department_name}</a></p>

                        <p>原文地址：<a href="/blog/detail/${blog.id}">${_webRootPath}/blog/detail/${blog.id}</a>
                        </p>

                        <p>转载时必须以链接形式注明原始出处及本声明。</p>
                    </div>
                    <!-- 文章版权信息 -->
                    <!-- Baidu Button BEGIN -->
                    <div class="clearfix" id="bdshare">
                        <div class="bdsharebuttonbox pull-right bdshare-button-style1-24" data-bd-bind="1405763231965">
                            <a href="#" class="bds_more" data-cmd="more"></a>
                            <a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
                            <a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
                            <a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a>
                            <a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a>
                            <a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a>
                        </div>
                    </div>
                    <script>
                        window._bd_share_config = {"common": {"bdSnsKey": {}, "bdText": "", "bdMini": "2", "bdMiniList": false, "bdPic": "", "bdStyle": "1", "bdSize": "24"}, "share": {}};
                        with (document)0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=' + ~(-new Date() / 36e5)];
                    </script>
                </div>
            </article>
        </#if>
    </div>
    <div class="col-md-3">
        <#include "/view/blog/_aside.ftl"/>
    </div>
</div>
</@layout>