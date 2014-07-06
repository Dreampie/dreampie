<#include "/view/layout/_layout.ftl"/>
<@layout activebar="index" html_title=i18n.getText("index.name")>
<#--<h1><@shiro.guest>Hello guest!</@shiro.guest>-->
    <#--<@shiro.hasRole name="user">Hello user!</@shiro.hasRole>-->
    <#--<@shiro.hasRole name="admin">Hello admin!</@shiro.hasRole></h1>-->
<h1>欢迎访问梦想派-Dreampie</h1>
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
<script type="application/javascript">
    $(function () {
        $('.carousel').carousel({
            interval: 2000
        })

    });
</script>
</@layout>