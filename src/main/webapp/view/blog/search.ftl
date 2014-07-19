<#include "/view/layout/_layout.ftl"/>
<@layout activebar="blog" html_title=i18n.getText("blog.name")>
<link rel="stylesheet" type="text/css" href="<@resource.static/>/css/app/blog/blog.css"/>
<!-- 面包屑 -->
<ol class="breadcrumb panel">
    <li><i class="fa fa-home"></i>&nbsp;<a title="Go to Home." href="/">Dreampie</a></li>
    <li><a title="Go to Blog." href="/blog">Blog</a></li>
    <li class="active">Search</li>
</ol>
<!-- 面包屑 -->

<div class="row">
    <div class="col-md-4 searchline">
        <form id="user_search" class="searchbar " role="form" action="/blog/search" method="get" data-view="searchbar"
              data-classname="col-sm-4"
              data-inputclass="form-control" data-placeholder="标题,内容,标签等">
            <span style=" position: relative; ">
                <input class="tt-hint" type="text" autocomplete="off" spellcheck="off" disabled="">
                <input name="blog_search" type="text" value="${(blog_search)!}" placeholder="标题,内容,标签等"
                       class="form-control tt-query"
                       spellcheck="false" maxlength="20"
                       dir="auto" style="/* position: relative; */vertical-align: top;background-color: transparent;">
                <span class="tt-dropdown-menu"
                      style="position: absolute; top: 100%; left: 0px; z-index: 100; display: none;"></span>
            </span>
            <button type="submit" class="glyphicon glyphicon-search search"></button>
        </form>
    </div>
</div>

<div class="row">
    <#if blogs?? && blogs?size gt 0>
        <#list blogs.list as blog>
            <section class="col-md-4">
                <div class="article thumbnail clearfix">
                    <i class="fa fa-bookmark article-stick visible-md visible-lg"></i>

                    <div class="data-article hidden-xs">
                        <span class="month">${blog.created_at?string("MM")}月</span>
                        <span class="day">${blog.created_at?string("dd")}</span>
                    </div>
                    <!-- PC端设备文章属性 -->
                    <section class="visible-md visible-lg">
                        <div class="title-article">
                            <h1><a href="/blog/detail/${blog.id}">${blog.title}</a></h1>
                        </div>
                        <div class="tag-article">
                        <span class="label label-support"><i class="fa fa-tags"></i>
                            <#if blog.tags??>
                                <#assign tags=blog.tags?split(",")>
                                <#list tags as tag>
                                    <a href="/blog/search?tags=${tag}" title="查看${tag}中的全部文章"
                                       rel="category tag">${tag}</a>
                                    <#if tag_index!=tags?size-1>
                                        ,
                                    </#if>
                                </#list>
                            </#if></span>
                        <span class="label label-support"><i class="fa fa-user"></i> <a
                                href="/user/detail" title="由${blog.full_name}发布" rel="author">${blog.full_name}</a></span>
                            <span class="label label-support"><i class="fa fa-eye"></i> ${blog.support_count}人</span>
                        </div>
                        <div class="content-article">
                            <figure class="thumbnail"><a href="http://www.yeahzan.com/zanblog/archives/843.html">
                                <img width="730" height="292"
                                     src="http://www.yeahzan.com/zanblog/wp-content/uploads/2014/07/zanblog3.jpg"
                                     class="attachment-730x300 wp-post-image"
                                     alt="ZanBlog3.0.0 正式发布！"
                                     title="ZanBlog3.0.0 正式发布！"></a>
                            </figure>
                            <div class="alert alert-article">
                                <#if blog.body?? && blog.body?length gt 200>
                                ${blog.body?substring(0,200)}
                                    ...
                                <#else>
                                ${blog.body}
                                </#if>
                            </div>
                        </div>
                        <a class="btn btn-danger pull-right read-more" href="/blog/detail/${blog.id}"
                           title="详细阅读 ${blog.title}">阅读全文 <span class="badge">${blog.hit_count}</span></a>

                    </section>
                    <!-- PC端设备文章属性 -->
                    <!-- 移动端设备文章属性 -->
                    <section class="visible-xs  visible-sm">
                        <div class="title-article">
                            <h4><a href="/blog/detail/${blog.id}">${blog.title}</a></h4>
                        </div>
                        <p>
                            <i class="fa fa-calendar"></i> ${blog.created_at?string("dd-MM")} <i class="fa fa-eye"></i> ${blog.support_count}人
                        </p>

                        <div class="content-article">
                            <figure class="thumbnail">
                                <a href="/blog/detail/${blog.id}"><img
                                        width="730" height="292"
                                        src="${blog.path!'http://www.yeahzan.com/zanblog/wp-content/uploads/2014/07/zanblog3.jpg'}"
                                        class="attachment-730x300 wp-post-image" alt="ZanBlog3.0.0 正式发布！"
                                        title="${blog.title}"></a></figure>
                            <div class="alert alert-article">
                            ${blog.body}
                                <#if blog.body?? && blog.body?size gt 100>
                                    ...
                                </#if>
                            </div>
                        </div>
                        <a class="btn btn-danger pull-right read-more btn-block"
                           href="/blog/detail/${blog.id}" title="详细阅读 ${blog.title}">阅读全文 <span
                                class="badge">${blog.hit_count}</span></a>
                    </section>
                    <!-- 移动端设备文章属性 -->

                </div>
            </section>
        </#list>
    </#if>
</div>
</@layout>