<#include "/view/layout/_layout.ftl"/>
<@layout activebar="index" html_title=i18n.getText("index.name")>
<link rel="stylesheet" href="<@resource.static/>/lib/bootstrap/css/bootstrap-tour.min.css"/>
<script type="text/javascript" src="<@resource.static/>/lib/bootstrap/js/bootstrap-tour.min.js"></script>
<h1><@shiro.guest>Hello guest!</@shiro.guest>
    <@shiro.hasRole name="user">Hello user!</@shiro.hasRole>
    <@shiro.hasRole name="admin">Hello admin!</@shiro.hasRole></h1>
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
        var tour = new Tour({
//            onStart: function() {
//                return $demo.addClass("disabled", true);
//            },
//            onEnd: function() {
//                return $demo.removeClass("disabled", true);
//            },
            debug: false,
            template: "<div class='popover tour' style='max-width: 400px;'><div class='arrow'>" +
                    "</div><h3 class='popover-title'></h3><div class='popover-content'></div>" +
                    "<div class='popover-navigation' style='min-width: 260px;'><button class='btn btn-primary btn-sm' data-role='prev'>上一步</button>" +
                    "<span data-role='separator'>&nbsp;&nbsp;&nbsp;&nbsp;</span>" +
                    "<button class='btn btn-primary btn-sm' data-role='next'>下一步</button>" +
                    "<button class='btn btn-info btn-sm' data-role='end'>退出</button></div></div>",
            steps: [
                {
                    path: "",
                    element: "#menubtn",
                    placement: "bottom",
                    title: "欢迎来到Dreampie",
                    content: "点击该按钮访问菜单.",
                    backdrop: false,
                    reflex: true
                },
                {
                    path: "",
                    element: "#userbtn",
                    placement: "bottom",
                    title: "欢迎来到Dreampie",
                    content: "点击该按钮可以访问用户信息.",
                    backdrop: false,
                    reflex: true
                }
            ]
        }).init().start();
    });
</script>
</@layout>