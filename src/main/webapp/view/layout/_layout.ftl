<#macro layout activebar html_title>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xml:lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable = no,minimal-ui"/>
    <!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <!--IE兼容模式-->
    <meta http-equiv="X-UA-Compatible" content="IE=8,chrome=1">
    <meta name="copyright" content="Copyright 梦想派(追梦派)官方网站">
    <meta name="author" content="wangrenhui1990@gmail.com"/>
    <meta name="keywords" content="梦想,追梦,梦想派,追梦派,梦想派官方,梦想派官网,追梦派官方，追梦派官网">
    <meta name="description" content="梦想派(追梦派)是一个开源集成框架，用户可以依赖该框架构建输入自己开源网站！">
    <link rel="apple-touch-icon-precomposed" href=<@resource.static/>/image/favicon..png">
    <link rel="shortcut icon" href="<@resource.static/>/image/favicon.ico"/>
    <!--百度站长验证-->
    <meta name="baidu-site-verification" content="ejR7RPMvau"/>
    <!--google站长验证-->
    <meta name="google-site-verification" content="ALViN24w3GrrIVAL-93BULRE99fdlBXw0V8QSXvSs7E"/>
    <!-- 最新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="<@resource.static/>/webjars/bootstrap/3.2.0/css/bootstrap.min.css" media="screen"/>
    <!--矢量文字图标-->
    <link rel="stylesheet" href="<@resource.static/>/webjars/font-awesome/4.1.0/css/font-awesome.min.css">

    <!--messenger-->
    <link rel="stylesheet" href="<@resource.static/>/javascript/lib/bootstrap/css/messenger.css" media="screen"/>
    <link rel="stylesheet" href="<@resource.static/>/javascript/lib/bootstrap/css/messenger-theme-block.css"
          media="screen"/>
    <!--滑动布局-->
    <link rel="stylesheet" type="text/css" href="<@resource.static/>/javascript/lib/mmenu/css/jquery.mmenu.all.css"/>
    <!--自定义样式-->
    <link rel="stylesheet" type="text/css" href="<@resource.static/>/css/app/_layout.css"/>

    <script src="<@resource.static/>/webjars/requirejs/2.1.14/require.min.js"></script>
<#-- base href="${CPATH}" / -->
    <script type="text/javascript">
        require(['../../javascript/app'], function () {
            require(['_layout'], function () {
                $(function () {
                    //初始化高度
                    $.reHeight = function () {
                        var height = Math.max(document.body.clientHeight, document.documentElement.clientHeight);
//                    h = $(".header-main").outerHeight() + $(".footer-main").outerHeight() + 35,
                        h = $(".footer-main").outerHeight() + 35,
                                _fn = function (h) {
//                                console.log(h);
                                    $(".container-main").eq(0).css("min-height", h + "px");
                                };
                        _fn(height - h);
                    }
                    $.reHeight();

                    $(window).resize(function () {
                        $.reHeight();
                    });
                    //初始化菜单
                    $('nav#menu-left').mmenu({offCanvas: {position: 'left'/*,zposition: "front"*/}, classes: 'mm-light',
                        dragOpen: true,
                        counters: true,
                        searchfield: true,
                        header: {add: true, update: true, title: '菜单'}});

                    $('nav#menu-right').mmenu({offCanvas: {position: 'right'/*,zposition: "front"*/}, classes: 'mm-light',
                        dragOpen: true,
                        counters: true,
                        searchfield: true,
                        header: {add: true, update: true, title: '<@shiro.principal property="full_name"/>'}});
                });
            });
        });
    </script>
    <title>${html_title}</title>
</head>
<body>
<!--http://www.cnblogs.com/steden/archive/2010/08/14/1799651.html-->
<nav id="menu-left" class="mm-menu mm-offcanvas">
    <ul>
        <li class="<#if activebar == 'index'> Selected </#if>"><a href="/">首页</a></li>
        <li class="<#if activebar == 'blog'> Selected </#if>"><a href="/blog">博客</a></li>
    </ul>
</nav>
<nav id="menu-right" class="mm-menu mm-offcanvas">
    <ul>
        <@shiro.notAuthenticated>
            <li class="<#if activebar == 'tosignup'> Selected </#if>">
                <a id="tosignup" class=""
                   href="/tosignup">${i18n.getText("user.signup")}</a></li>
            <li class="<#if activebar == 'tologin'> Selected </#if>">
                <a id="tologin" class=""
                   href="/tologin">${i18n.getText("user.login")}</a></li>
        </@shiro.notAuthenticated>
        <@shiro.authenticated>
            <li class="<#if activebar == 'center'> Selected </#if>"><a
                    href="/user/center">${i18n.getText("user.center")}</a>
            </li>
            <li class="<#if activebar == 'following'> Selected </#if>">
                <a href="/user/following">${i18n.getText("user.following")}</a></li>
            <li class="<#if activebar == 'follower'> Selected </#if>">
                <a href="/user/follower">${i18n.getText("user.follower")}</a></li>
            <li class="<#if activebar == 'search'> Selected </#if>">
                <a href="/user/search">${i18n.getText("user.search")}</a></li>
            <@shiro.hasPermission name="P_USER">
                <li><a href="/admin/user">${i18n.getText("admin.user")}</a></li>
            </@shiro.hasPermission>
            <@shiro.hasPermission name="P_ROLE">
                <li class="<#if activebar == 'role'> Selected </#if>">
                    <a href="/admin/role">${i18n.getText("admin.role")}</a></li>
            </@shiro.hasPermission>
            <li><a href="/logout">${i18n.getText("user.logout")}</a></li>
        </@shiro.authenticated>
        <li><a target="_blank" href="/view/demo/chat.html">聊天demo</a></li>
    </ul>
</nav>

<!--container-->
<div id="page">
    <!--Site header-->
    <div id="header" class="mm-fixed-top navbar navbar-inverse header-main">
        <div class="container-fluid">
            <div class="header-sm">
                <ul class="nav fleft">
                    <li>
                        <a class="menu-btn navbar-toggle navbar-btn" href="#menu-left">
                            <span class="glyphicon glyphicon-th-large"></span>
                        </a></li>
                </ul>
                <a href="/">
                    <img src="/image/logo.png" style="height: 48px;*height:50px" alt=""/>
                </a>
                <ul class="nav fright">
                    <li>
                        <a class="menu-btn navbar-toggle navbar-btn" href="#menu-right">
                            <span class="glyphicon glyphicon-user"></span>
                        </a></li>
                </ul>
            </div>
            <div class="header-default" role="navigation">
                <ul class=" navbar-left nav navbar-nav">
                    <li>
                        <a id="menubtn" class="menu-btn tour-tour-element tour-tour-0-element tour-step-backdrop"
                           href="#menu-left">
                            <span class="glyphicon glyphicon-th-large"></span>
                        </a>
                    </li>
                </ul>
                <a style="padding: 0px" href="/">
                    <img src="/image/logo.png" style="height: 48px;*height:50px" alt=""/>
                </a>
                <ul class="navbar-right nav navbar-nav">
                    <li>
                        <a id="userbtn" class="menu-btn tour-tour-element tour-tour-1-element tour-step-backdrop"
                           href="#menu-right">
                            <span class="glyphicon glyphicon-user"
                                  style="<@shiro.notAuthenticated>color: lightgray;</@shiro.notAuthenticated>"></span>
                        </a>
                    </li>
                </ul>
            </div>

        </div>
    </div>

    <!--页面内容-->
    <div id="content" class="container-fluid main container-main">

        <!--[if lte IE 7]>
        <div id="ie-warning" class="alert alert-danger fade out">
            <button type="button" class="close" data-dismiss="alert">×</button>
            <i class="fa fa-warning"></i> 请注意，Dreampie并不支持低于IE8的浏览器，为了获得最佳效果，请下载最新的浏览器，推荐下载
            <a href="http://www.google.cn/intl/zh-CN/chrome/" target="_blank"><i class="fa fa-compass"></i> Chrome</a>
            <a href="http://www.firefox.com.cn/download/" target="_blank"><i class="fa fa-compass"></i> Firefox</a>
        </div>
        <script type="text/javascript">
            $(function () {
                require(['../../javascript/app'], function () {
                    require(['jquery'], function () {
                        if (!$.support.leadingWhitespace) {
                            $('#ie-warning').removeClass("out");
                            $('#ie-warning').addClass("in");
                        }
                    });
                });
            })
        </script>
        <![endif]-->

        <#nested>
    </div>

    <!-- Site footer -->
    <div class="footer footer-main">
        <div class="container-fluid">
            <p>${i18n.getText("app.copyright")}</p>

            <p>
                <a href="http://www.miibeian.gov.cn/"
                   target="_blank">${i18n.getText("app.gov")}</a>
            </p>
        </div>
    </div>
</div>
<!-- /container -->

<script type="text/javascript">
    /**
     * make elements in container el to be compatible with IE6
     */
    require(['../../javascript/app'], function () {
        require(['_layout'], function () {
            $(function () {
                /*  $(".navbar").scrollHide({
                    animation: 'fade'// Fade, slide, none
                  });*/
                // IE10 viewport hack for Surface/desktop Windows 8 bug
                //
                // See Getting Started docs for more information
                if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
                    var msViewportStyle = document.createElement("style");
                    msViewportStyle.appendChild(
                            document.createTextNode(
                                    "@-ms-viewport{width:auto!important}"
                            )
                    );
                    document.getElementsByTagName("head")[0].
                            appendChild(msViewportStyle);
                }

                $("img.lazy").unveil();

                $.scrollUp({
                    scrollName: 'scrollUp', // Element ID
                    topDistance: '300', // Distance from top before showing element (px)
                    topSpeed: 300, // Speed back to top (ms)
                    animation: 'fade', // Fade, slide, none
                    animationInSpeed: 200, // Animation in speed (ms)
                    animationOutSpeed: 200, // Animation out speed (ms)
                    scrollText: '', // Text for element
                    activeOverlay: false,  // Set CSS color to display scrollUp active point, e.g '#00FFFF'
                    className:'fa fa-angle-up'//class
                });
                //消息插件
                Messenger.options = {
                    extraClasses: 'messenger-fixed messenger-on-bottom messenger-on-right',
                    theme: 'block'
                };
                var messenger;
                var errormessenger;
                $(document).ajaxStart(function (e) {
                    messenger = Messenger().post({
                        message: '正在执行请求,请稍后...',
                        type: 'info',
                        showCloseButton: true
                    });
                }).ajaxComplete(function (e) {
                    messenger.hide();
                }).ajaxSuccess(function (e) {
                    messenger.update("已完成请求,正在加载...");
                }).ajaxError(function (event, xhr, options, exc) {
                    var msg = "服务器未响应!";
                    if ($.trim(exc) == 'Unauthorized') msg = "没有权限访问或没有登录!";
                    if ($.trim(exc) == 'Not Found') msg = "访问内容找不到了!";
                    if ($.trim(exc) == 'Server Error') msg = "服务异常!";
                    if ($.trim(exc) == 'Forbidden') msg = "拒绝访问!";
                    errormessenger = Messenger().post({
                        message: msg,
                        type: 'error',
                        showCloseButton: true
                    });
                });
                //教程提示
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
        });
    });
</script>
</body>
</html>
</#macro>