<#macro layout activebar html_title>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xml:lang="zh-CN" xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
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

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script type="text/javascript" src="<@resource.static/>/javascript/jquery-1.10.2.min.js"></script>
<#-- base href="${CPATH}" / -->
    <script type="text/javascript">
        $(function () {
            ~(function (window, document, $) {
                var height = Math.max(document.body.clientHeight, document.documentElement.clientHeight);
                h = $(".header-main").outerHeight() + $(".footer-main").outerHeight() + 35,
                        _fn = function (h) {
                            $(".container-main").eq(0).css("min-height", h + "px");
                        };
                _fn(height - h);
            })(window, document, $);
        });
    </script>
    <title>${html_title}</title>
</head>
<body>
<!--http://www.cnblogs.com/steden/archive/2010/08/14/1799651.html-->
<!--container-->
<!--Site header-->
<header class="navbar navbar-default navbar-fixed-top headroom header-main">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav active">
            <#--<li><button type="button" class="navbar-toggle" style="display: block;min-height:44px;border-bottom: 0px;border-top:0px;border-radius:0px;margin: 0px;">-->
            <#--<span class="icon-bar"></span>-->
            <#--<span class="icon-bar"></span>-->
            <#--<span class="icon-bar"></span>-->
            <#--</button></li>-->
                <li class="<#if activebar == 'index'> active </#if>"><a href="/">${i18n.getText("index.name")}</a></li>
                <@shiro.hasPermission name="P_ROLE">
                    <li class="<#if activebar == 'role'> active </#if>"><a
                            href="/admin/role">${i18n.getText("role.name")}</a>
                    </li>
                </@shiro.hasPermission>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="<#if activebar == 'toregister'> active </#if>">
                    <a id="toregister" class="tour-tour-element tour-tour-1-element tour-step-backdrop"
                       href="/toregister">${i18n.getText("user.register")}</a></li>
                <li class="divider-vertical"></li>
                <@shiro.notAuthenticated>
                    <li class="<#if activebar == 'tologin'> active </#if>">
                        <a id="tologin" class="tour-tour-element tour-tour-0-element tour-step-backdrop"
                           href="/tologin">${i18n.getText("user.login")}</a></li>
                </@shiro.notAuthenticated>
                <@shiro.authenticated>
                    <li class="<#if activebar == 'center'> active </#if> dropdown">
                        <a href="#" class="dropdown-toggle"
                           data-toggle="dropdown"><@shiro.principal property="full_name"/>
                            <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="/user/center">${i18n.getText("user.center")}</a></li>
                        <#--<li><a href="#">应用中心</a></li>
                        <li><a href="#">设置</a></li>-->
                            <li class="divider"></li>
                            <li><a href="/logout">${i18n.getText("user.logout")}</a></li>
                        </ul>
                    </li>
                </@shiro.authenticated>
            </ul>
        </div>

    </div>
</header>

<!--页面内容-->
<div class="container main container-main">
    <#nested>
</div>

<!-- Site footer -->
<div class="footer footer-main">
    <div class="container">
        <p>${i18n.getText("webapp.copyright")} - <a href="http://www.miibeian.gov.cn/"
                                                    target="_blank">${i18n.getText("webapp.gov")}</a>
        </p>
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
<!-- bsie js patch, it will only execute in IE6 -->
<!--[if lte IE 7]>
<script type="text/javascript" src="<@resource.static/>/libs/bootstrap/js/bootstrap-ie.js"></script>
<script type="text/javascript" src="<@resource.static/>/javascript/layout/selectivizr-min.js"></script>
<![endif]-->
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
//jquery i18n
//            jQuery.i18n.properties({
//                name: 'messages',
//                path:'/',
//                callback: function(){ alert( $.i18n.prop('webapp.name') ); }
//            });

        });
    }(jQuery)
</script>
</body>
</html>
</#macro>