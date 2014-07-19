<#include "/view/layout/_layout.ftl"/>
<@layout activebar="center" html_title="个人中心">

<!-- 面包屑 -->
<ol class="breadcrumb panel">
    <li><i class="fa fa-home"></i>&nbsp;<a title="Go to Home." href="/">Dreampie</a></li>
    <li class="active">User</li>
</ol>
<!-- 面包屑 -->

<style type="text/css">
    .thumbnail {
        width: 30%;
    }

    .thumbnail p {
        word-break: break-all;
    }
</style>
<div id="addressBook" class="container-fluid">
    <div class="thumbnail">
        <img data-src="<@resource.static/>/javascript/layout/holder.js/300x200" alt="...">

        <div class="caption">
            <h3>Thumbnail label</h3>

            <p>
                sfsdfssdsdsdsdsdsdsdsfsdfssdsdsdsdsdsdsdsfsdfssdsdsdsdsdsdsdsfsdfssdsdsdsdsdsdsdsfsdfssdsdsdsdsdsdsdsfsdfssdsdsdsdsdsdsdsfsdfssdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsfsdfssdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsd</p>

            <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default"
                                                                               role="button">Button</a></p>
        </div>
    </div>
    <div class="thumbnail">
        <img data-src="<@resource.static/>/javascript/layout/holder.js/300x200" alt="...">

        <div class="caption">
            <h3>Thumbnail label</h3>

            <p>sfsdfssdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsd</p>

            <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default"
                                                                               role="button">Button</a></p>
        </div>
    </div>
    <div class="thumbnail">
        <img data-src="<@resource.static/>/javascript/layout/holder.js/300x200" alt="...">

        <div class="caption">
            <h3>Thumbnail label</h3>

            <p>sfsdfssdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsd</p>

            <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default"
                                                                               role="button">Button</a></p>
        </div>
    </div>
    <div class="thumbnail">
        <img data-src="<@resource.static/>/javascript/layout/holder.js/300x200" alt="...">

        <div class="caption">
            <h3>Thumbnail label</h3>

            <p>sfsdfssdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsd</p>

            <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default"
                                                                               role="button">Button</a></p>
        </div>
    </div>
    <div class="thumbnail">
        <img data-src="<@resource.static/>/javascript/layout/holder.js/300x200" alt="...">

        <div class="caption">
            <h3>Thumbnail label</h3>

            <p>sfsdfssdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsdsd</p>

            <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default"
                                                                               role="button">Button</a></p>
        </div>
    </div>
</div>
</@layout>

<script type="text/javascript">
    require(['../../javascript/app'], function () {
        require(['masonry'], function () {
            $(function () {
                $('#addressBook').masonry({
                    columnWidth: 200,
                    itemSelector: '.thumbnail'
                });
            });
        });
    });

</script>