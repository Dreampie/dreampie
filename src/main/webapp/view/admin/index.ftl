<#include "/view/layout/_layout.ftl"/>
<@layout activebar="index" html_title="首页">

<!-- 面包屑 -->
<ol class="breadcrumb panel">
    <li><i class="fa fa-home"></i>&nbsp;<a title="Go to Home." href="/">Dreampie</a></li>
    <li class="active">Admin</li>
</ol>
<!-- 面包屑 -->

<h1>Admin User </h1>
<div id="carousel-example-captions" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
        <li data-target="#carousel-example-captions" data-slide-to="0" class="active"></li>
        <li data-target="#carousel-example-captions" data-slide-to="1" class=""></li>
        <li data-target="#carousel-example-captions" data-slide-to="2" class=""></li>
    </ol>
    <div class="carousel-inner">
        <div class="item active">
            <img data-src="holder.js/1140x500/auto/#777:#777" alt="900x500" src="/image/carousel_base.png">

            <div class="carousel-caption">
                <h3>First slide label</h3>

                <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
            </div>
        </div>
        <div class="item">
            <img data-src="holder.js/1140x500/auto/#666:#666" alt="900x500" src="/image/carousel_base.png">

            <div class="carousel-caption">
                <h3>Second slide label</h3>

                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
            </div>
        </div>
        <div class="item">
            <img data-src="holder.js/1140x500/auto/#555:#5555" alt="900x500" src="/image/carousel_base.png">

            <div class="carousel-caption">
                <h3>Third slide label</h3>

                <p>Praesent commodo cursus magna, vel scelerisque nisl consectetur.</p>
            </div>
        </div>
    </div>
    <a class="left carousel-control" href="#carousel-example-captions" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left"></span>
    </a>
    <a class="right carousel-control" href="#carousel-example-captions" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right"></span>
    </a>
</div>
<script type="text/javascript">
    require(['../../javascript/app'], function () {
        require(['bootstrap'], function () {
            $(function () {
                $('.carousel').carousel({
                    interval: 2000
                })
            });
        });
    });
</script>
</@layout>