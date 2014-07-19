<#include "/view/layout/_layout.ftl"/>
<@layout activebar="index" html_title=i18n.getText("index.name")>

<link rel="stylesheet" type="text/css" href="<@resource.static/>/css/app/_carousel.css"/>

<!-- 面包屑 -->
<ol class="breadcrumb panel">
    <li class="active"><i class="fa fa-home"></i>&nbsp;Dreampie</li>
</ol>
<!-- 面包屑 -->

<div class="alert panel fade in">
    <button type="button" class="close" data-dismiss="alert">×</button>
    欢迎使用由 <a target="_blank" class="alert-link" href="http://www.bootcss.com/">Bootstrap</a> 提供的 <strong>主题</strong>，如有问题可以查看Bootstrap官网的<a class="alert-link" target="_blank" href="http://blog.bootcss.com/">Blog</a>内容,除主题之外的其他问题联系
    <a target="_blank" class="alert-link" href="https://github.com/Dreampie/dreampie">Dreampie</a> <i class="fa fa-smile-o"></i>
</div>

<#--<h1><@shiro.guest>Hello guest!</@shiro.guest>-->
<#--<@shiro.hasRole name="user">Hello user!</@shiro.hasRole>-->
<#--<@shiro.hasRole name="admin">Hello admin!</@shiro.hasRole></h1>-->



<h1>欢迎访问梦想派-Dreampie</h1>

<script type="text/javascript">
    require(['../javascript/app'], function () {
        require(['blog_views'], function () {
            blogs = new App.Models.Blogs();
//            blogs.fetch();
            blogsView=new App.Views.Blogs().renew();
        });
    });
</script>
<!--backbone-->
<a href="/#/blog">blogs backbone demo</a>
<div id="main"></div>
<script type="text/template" id="main_blogs">
    <% blogs.each(function(blog) { %>
    <%= blog.get("id") %>
    <%= blog.get("title") %>
    <%= blog.get("body") %>
    <%});%>
</script>
<!--backbone-->

<div id="carousel-index" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
        <li data-target="#carousel-index" data-slide-to="0" class="active"></li>
        <li data-target="#carousel-index" data-slide-to="1" class=""></li>
        <li data-target="#carousel-index" data-slide-to="2" class=""></li>
    </ol>
    <div class="carousel-inner">
        <div class="item active masthead">
            <div class="masthead-bg"></div>
            <div class="container-fluid">
                <div class="carousel-caption">
                    <h3>First slide label</h3>

                    <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="masthead-bg"></div>
            <div class="container-fluid">
                <div class="carousel-caption">
                    <h3>Second slide label</h3>

                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="masthead-bg"></div>
            <div class="container-fluid">
                <div class="carousel-caption">
                    <h3>Third slide label</h3>

                    <p>Praesent commodo cursus magna, vel scelerisque nisl consectetur.</p>
                </div>
            </div>
        </div>
    </div>
    <a class="left carousel-control" href="#carousel-index" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left"></span>
    </a>
    <a class="right carousel-control" href="#carousel-index" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right"></span>
    </a>
</div>
<script type="text/javascript">
    require(['../javascript/app'], function () {
        require(['_layout'], function () {
            $(function () {
                $('.carousel').carousel({
                    interval: 2000
                })
            });
        });
    });
</script>

<#--富文本编辑器-->
<#--<!-- include summernote cs/js&ndash;&gt;-->
<#--<div class="summernote">Hello Summernote</div>-->
<#--<link rel="stylesheet" type="text/css" href="<@resource.static/>/webjars/codemirror/4.3/lib/codemirror.css"/>-->
<#--<script type="text/javascript">-->
    <#--require(['../javascript/app'], function () {-->
        <#--require(['_layout', 'summernote', 'summernote-zh-CN', 'codemirror'], function () {-->
            <#--$(function () {-->
                <#--$('.summernote').summernote({-->
                    <#--height: 300,                 // set editor height-->
                    <#--minHeight: null,             // set minimum height of editor-->
                    <#--maxHeight: null,             // set maximum height of editor-->
                    <#--focus: true,-->
                    <#--lang: 'zh-CN', // default: 'en-US'-->
                    <#--codemirror: { // codemirror options-->
                        <#--theme: 'monokai'-->
                    <#--}-->
                <#--});-->
            <#--});-->


        <#--});-->
    <#--});-->
<#--</script>-->

代码高亮
<pre>
    <code class="html">
        &lt;link href="<@resource.static/>/lib/google-code-prettify/prettify.css" type="text/css" rel="stylesheet"/&gt;
        &lt;script type="text/javascript" src="<@resource.static/>/lib/google-code-prettify/prettify.js"&gt;&lt;/script&gt;
    </code>
</pre>

</@layout>