<#macro layout activebar html_title>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xml:lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable = no"/>
    <!--IE兼容模式-->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="shortcut icon" href="<@resource.static/>/images/favicon.ico"/>
    <!-- 最新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="<@resource.static/>/libs/bootstrap/css/bootstrap.min.css" media="screen"/>

    <!-- 可选的Bootstrap主题文件（一般不用引入） -->
    <link rel="stylesheet" href="<@resource.static/>/libs/bootstrap/css/bootstrap-theme.min.css" media="screen"/>

    <link rel="stylesheet" href="<@resource.static/>/libs/bootstrap/css/font-awesome.min.css">

    <!--messenger-->
    <link rel="stylesheet" href="<@resource.static/>/libs/bootstrap/css/messenger.css" media="screen"/>
    <link rel="stylesheet" href="<@resource.static/>/libs/bootstrap/css/messenger-theme-block.css" media="screen"/>
    <!--[if lte IE 7]>
    <link rel="stylesheet" href="a<@resource.static/>/libs/bootstrap/css/font-awesome-ie7.min.css">
    <![endif]-->

    <!-- bsie css 补丁文件 -->
    <!-- bsie 额外的 css 补丁文件 -->
    <!--[if lte IE 7]>
    <link rel="stylesheet" type="text/css" href="<@resource.static/>/libs/bootstrap/css/bootstrap-ie.css"/>
    <link rel="stylesheet" type="text/css" href="<@resource.static/>/libs/bootstrap/css/ie.css"/>
    <![endif]-->
    <!--自定义样式-->
    <link rel="stylesheet" type="text/css" href="<@resource.static/>/css/layout/_layout.css" media="screen"/>
    <link rel="stylesheet" type="text/css" href="<@resource.static/>/libs/mmenu/css/jquery.mmenu.all.css"
          media="screen"/>
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script type="text/javascript" src="<@resource.static/>/javascript/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="<@resource.static/>/libs/mmenu/js/jquery.mmenu.min.all.js"></script>
    <script type="text/javascript" src="<@resource.static/>/libs/mmenu/js/jquery.hammer.min.js"></script>
<#-- base href="${CPATH}" / -->
    <script type="text/javascript">
        $(function () {
            //初始化高度
            ~(function (window, document, $) {
                var height = Math.max(document.body.clientHeight, document.documentElement.clientHeight);
                h = $(".header-main").outerHeight() + $(".footer-main").outerHeight() + 35,
                        _fn = function (h) {
                            $(".container-main").eq(0).css("min-height", h + "px");
                        };
                _fn(height - h);
            })(window, document, $);

            //初始化菜单
            $('nav#menu-left').mmenu({classes: 'mm-slide',
                dragOpen: true,
                counters: true,
                searchfield: true,
                header: {add: true, update: true, title: 'Menu'}});

            $('nav#menu-right').mmenu({offCanvas: {position: 'right'}, classes: 'mm-light',
                dragOpen: true,
                counters: true,
                searchfield: true,
                header: {add: true, update: true, title: '<@shiro.principal property="full_name"/>'}});
        });
    </script>
    <title>${html_title}</title>
</head>
<body>
<!--http://www.cnblogs.com/steden/archive/2010/08/14/1799651.html-->
<!--container-->
<div id="page">
<!--Site header-->
<div id="header" class="navbar navbar-default headroom header-main mm-fixed-top">
    <div class="container-fluid">
        <div class="header-sm">
            <a style="padding: 0px" href="/">
                <img src="/images/logo.jpg" style="height: 48px;*height:50px" alt=""/>
            </a>
            <ul class="nav fleft">
                <li>
                    <a class="menu-btn navbar-toggle navbar-btn" href="#menu-left">
                        <span class="glyphicon glyphicon-th-large"></span>
                    </a></li>
            </ul>
            <ul class="nav fright">
                <li>
                    <a class="menu-btn navbar-toggle navbar-btn" href="#menu-right">
                        <span class="glyphicon glyphicon-user"></span>
                    </a></li>
            </ul>
        </div>
        <div class="header-default">
            <a style="padding: 0px" href="/">
                <img src="/images/logo.jpg" style="height: 48px;*height:50px" alt=""/>
            </a>
            <ul class="nav navbar-nav navbar-left">
                <li>
                    <a id="menubtn" class="menu-btn" href="#menu-left">
                        <span class="glyphicon glyphicon-th-large"></span>
                    </a>
                </li>
                <#--<li>-->
                    <#--<a style="padding: 0px" href="/">-->
                        <#--<img src="/images/logo.jpg" style="height: 48px;*height:50px" alt=""/>-->
                    <#--</a>-->
                <#--</li>-->
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a class="menu-btn" href="#menu-right">
                        <span class="glyphicon glyphicon-user"></span>
                    </a>
                </li>
            </ul>
        </div>

    </div>
</div>
<nav id="menu-left">
    <ul>
        <li><a href="/">首页</a></li>
    </ul>
</nav>
<nav id="menu-right">
<ul>
    <@shiro.notAuthenticated>
    <li class="<#if activebar == 'toregister'> Selected </#if>">
        <a id="toregister" class="tour-tour-element tour-tour-1-element tour-step-backdrop"
           href="/toregister">${i18n.getText("user.register")}</a></li>
    <li class="<#if activebar == 'tologin'> Selected </#if>">
        <a id="tologin" class="tour-tour-element tour-tour-0-element tour-step-backdrop"
           href="/tologin">${i18n.getText("user.login")}</a></li>
    </@shiro.notAuthenticated>
    <@shiro.authenticated>
    <li class="<#if activebar == 'center'> Selected </#if>"><a href="/user/center">${i18n.getText("user.center")}</a>
    </li>
    <li><a href="/logout">${i18n.getText("user.logout")}</a></li>
    </@shiro.authenticated>
</ul>
<#--<span>Friends</span>-->
<#--<ul>-->
    <#--<li class="Label">A</li>-->
    <#--<li class="img">-->
        <#--<a href="#">-->
            <#--<img src="http://lorempixel.com/50/50/people/1/"/>-->
            <#--Alexa<br/>-->
            <#--<small>Johnson</small>-->
        <#--</a>-->
    <#--</li>-->
    <#--<li class="img">-->
        <#--<a href="#">-->
            <#--<img src="http://lorempixel.com/50/50/people/2/"/>-->
            <#--Alexander<br/>-->
            <#--<small>Brown</small>-->
        <#--</a>-->
    <#--</li>-->

    <#--<li class="Label">F</li>-->
    <#--<li class="img">-->
        <#--<a href="#">-->
            <#--<img src="http://lorempixel.com/50/50/people/3/"/>-->
            <#--Fred<br/>-->
            <#--<small>Smith</small>-->
        <#--</a>-->
    <#--</li>-->

    <#--<li class="Label">J</li>-->
    <#--<li class="img">-->
        <#--<a href="#">-->
            <#--<img src="http://lorempixel.com/50/50/people/4/"/>-->
            <#--James<br/>-->
            <#--<small>Miller</small>-->
        <#--</a>-->
    <#--</li>-->
    <#--<li class="img">-->
        <#--<a href="#">-->
            <#--<img src="http://lorempixel.com/50/50/people/5/"/>-->
            <#--Jefferson<br/>-->
            <#--<small>Jackson</small>-->
        <#--</a>-->
    <#--</li>-->
    <#--<li class="img">-->
        <#--<a href="#">-->
            <#--<img src="http://lorempixel.com/50/50/people/6/"/>-->
            <#--Jordan<br/>-->
            <#--<small>Lee</small>-->
        <#--</a>-->
    <#--</li>-->

    <#--<li class="Label">K</li>-->
    <#--<li class="img">-->
        <#--<a href="#">-->
            <#--<img src="http://lorempixel.com/50/50/people/7/"/>-->
            <#--Kim<br/>-->
            <#--<small>Adams</small>-->
        <#--</a>-->
    <#--</li>-->

    <#--<li class="Label">M</li>-->
    <#--<li class="img">-->
        <#--<a href="#">-->
            <#--<img src="http://lorempixel.com/50/50/people/8/"/>-->
            <#--Meagan<br/>-->
            <#--<small>Miller</small>-->
        <#--</a>-->
    <#--</li>-->
    <#--<li class="img">-->
        <#--<a href="#">-->
            <#--<img src="http://lorempixel.com/50/50/people/9/"/>-->
            <#--Melissa<br/>-->
            <#--<small>Johnson</small>-->
        <#--</a>-->
    <#--</li>-->

    <#--<li class="Label">N</li>-->
    <#--<li class="img">-->
        <#--<a href="#">-->
            <#--<img src="http://lorempixel.com/50/50/people/10/"/>-->
            <#--Nicole<br/>-->
            <#--<small>Smith</small>-->
        <#--</a>-->
    <#--</li>-->

    <#--<li class="Label">S</li>-->
    <#--<li class="img">-->
        <#--<a href="#">-->
            <#--<img src="http://lorempixel.com/50/50/people/1/"/>-->
            <#--Samantha<br/>-->
            <#--<small>Harris</small>-->
        <#--</a>-->
    <#--</li>-->
    <#--<li class="img">-->
        <#--<a href="#">-->
            <#--<img src="http://lorempixel.com/50/50/people/2/"/>-->
            <#--Scott<br/>-->
            <#--<small>Thompson</small>-->
        <#--</a>-->
    <#--</li>-->
<#--</ul>-->
<#--</li>-->

<#--<li>-->
    <#--<span>Family</span>-->
    <#--<ul>-->
        <#--<li class="Label">A</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/3/"/>-->
                <#--Adam<br/>-->
                <#--<small>White</small>-->
            <#--</a>-->
        <#--</li>-->

        <#--<li class="Label">B</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/4/"/>-->
                <#--Ben<br/>-->
                <#--<small>Robinson</small>-->
            <#--</a>-->
        <#--</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/5/"/>-->
                <#--Bruce<br/>-->
                <#--<small>Lee</small>-->
            <#--</a>-->
        <#--</li>-->

        <#--<li class="Label">E</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/6/"/>-->
                <#--Eddie<br/>-->
                <#--<small>Williams</small>-->
            <#--</a>-->
        <#--</li>-->

        <#--<li class="Label">J</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/7/"/>-->
                <#--Jack<br/>-->
                <#--<small>Johnson</small>-->
            <#--</a>-->
        <#--</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/8/"/>-->
                <#--John<br/>-->
                <#--<small>Jackman</small>-->
            <#--</a>-->
        <#--</li>-->

        <#--<li class="Label">M</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/9/"/>-->
                <#--Martina<br/>-->
                <#--<small>Thompson</small>-->
            <#--</a>-->
        <#--</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/10/"/>-->
                <#--Matthew<br/>-->
                <#--<small>Watson</small>-->
            <#--</a>-->
        <#--</li>-->

        <#--<li class="Label">O</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/1/"/>-->
                <#--Olivia<br/>-->
                <#--<small>Taylor</small>-->
            <#--</a>-->
        <#--</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/2/"/>-->
                <#--Owen<br/>-->
                <#--<small>Wilson</small>-->
            <#--</a>-->
        <#--</li>-->
    <#--</ul>-->
<#--</li>-->

<#--<li>-->
    <#--<span>Work colleagues</span>-->
    <#--<ul>-->
        <#--<li class="Label">D</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/3/"/>-->
                <#--David<br/>-->
                <#--<small>Harris</small>-->
            <#--</a>-->
        <#--</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/4/"/>-->
                <#--Dennis<br/>-->
                <#--<small>King</small>-->
            <#--</a>-->
        <#--</li>-->

        <#--<li class="Label">E</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/5/"/>-->
                <#--Eliza<br/>-->
                <#--<small>Walker</small>-->
            <#--</a>-->
        <#--</li>-->

        <#--<li class="Label">L</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/6/"/>-->
                <#--Larry<br/>-->
                <#--<small>Turner</small>-->
            <#--</a>-->
        <#--</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/7/"/>-->
                <#--Lisa<br/>-->
                <#--<small>Wilson</small>-->
            <#--</a>-->
        <#--</li>-->

        <#--<li class="Label">M</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/8/"/>-->
                <#--Michael<br/>-->
                <#--<small>Jordan</small>-->
            <#--</a>-->
        <#--</li>-->

        <#--<li class="Label">R</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/9/"/>-->
                <#--Rachelle<br/>-->
                <#--<small>Cooper</small>-->
            <#--</a>-->
        <#--</li>-->
        <#--<li class="img">-->
            <#--<a href="#">-->
                <#--<img src="http://lorempixel.com/50/50/people/10/"/>-->
                <#--Rick<br/>-->
                <#--<small>James</small>-->
            <#--</a>-->
        <#--</li>-->
    <#--</ul>-->
<#--</li>-->
<#--</ul>-->
</nav>
<!--页面内容-->
<div id="content" class="container-fluid main container-main">
    <#nested>
</div>

<!-- Site footer -->
<div class="footer footer-main">
    <div class="container-fluid">
        <p>${i18n.getText("webapp.copyright")} - <a href="http://www.miibeian.gov.cn/"
                                                    target="_blank">${i18n.getText("webapp.gov")}</a>
        </p>
    </div>
</div>
</div>
<!-- /container -->
<!--[if lte IE 7]>
<div class="modal fade" id="b_support_alert" tabindex="-1" role="dialog" aria-labelledby="b_support_alertModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="b_support_alertModalLabel">${i18n.getText("browser.suport.title")}</h4>
      </div>
      <div class="modal-body">
      ${i18n.getText("browser.suport.tip")}
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">${i18n.getText("webapp.close")}</button>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
$(function () {
  if (!$.support.leadingWhitespace) {
    $('#b_support_alert').modal();
  }
})
</script>
<![endif]-->

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script type="text/javascript" src="<@resource.static/>/libs/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<@resource.static/>/libs/bootstrap/js/bootstrapx-clickover.js"></script>
<!-- bsie js patch, it will only execute in IE6 -->
<!--[if lte IE 7]>
<script type="text/javascript" src="<@resource.static/>/libs/bootstrap/js/bootstrap-ie.js"></script>
<script type="text/javascript" src="<@resource.static/>/javascript/layout/selectivizr-min.js"></script>
<![endif]-->
<!--messager-->
<script type="text/javascript" src="<@resource.static/>/libs/bootstrap/js/messenger.min.js"></script>
<!--maxlength-->
<script type="text/javascript" src="<@resource.static/>/libs/bootstrap/js/bootstrap-maxlength.js"></script>
<!--全局js-->
<script type="text/javascript" src="<@resource.static/>/javascript/layout/_layout.js"></script>
<!--i18n-->
<#--<script type="text/javascript" language="JavaScript" src="<@resource.static/>/javascript/jquery.i18n.properties-min-1.0.9.js"></script>-->
<!--幕布实现的js-->
<!-- <script type="text/javascript" src="<@resource.static/>/javascript/layout/holder.js"></script>-->
<#--<script type="text/javascript" src="<@resource.static/>/javascript/layout/jquery.scrollHide.js"></script>-->
<!--回到头部js-->
<script type="text/javascript" src="<@resource.static/>/javascript/layout/jquery.scrollUp.min.js"></script>
<!--延迟加载图片-->
<script type="text/javascript" src="<@resource.static/>/javascript/layout/jquery.unveil.min.js"></script>

<!--[if lt IE 9]>
<script type="text/javascript" src="<@resource.static/>/javascript/layout/ie8-responsive-file-warning.js"></script>
<![endif]-->
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script type="text/javascript" src="<@resource.static/>/javascript/layout/html5shiv.min.js"></script>
<script type="text/javascript" src="<@resource.static/>/javascript/layout/respond.min.js"></script>
<![endif]-->
<script type="text/javascript">
    /**
     * make elements in container el to be compatible with IE6
     */
    !function ($) {
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
                activeOverlay: false  // Set CSS color to display scrollUp active point, e.g '#00FFFF'
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
        });
    }(jQuery)
</script>
</body>
</html>
</#macro>