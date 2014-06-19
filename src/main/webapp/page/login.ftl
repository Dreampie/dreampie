<#include "/page/layout/_layout.ftl"/>
<@layout activebar="tologin" html_title=i18n.getText("login.name")>
<link rel="stylesheet" href="<@resource.static/>/css/login.css"/>
<script type="text/javascript" src="<@resource.static/>/javascript/layout/jquery.form.js"></script>
<script type="text/javascript" src="<@resource.static/>/javascript/layout/_valid.js"></script>
<!--url param-->
<script type="text/javascript" src="<@resource.static/>/javascript/jquery.query.js"></script>
<form class="form-signin" id="signin" role="form" method="post" action="/login" autocomplete="off">
    <h2 class="form-signin-heading">Please sign in</h2>
    <input name="username" value="<@shiro.loginUsername/>" type="text" maxlength="18" class="form-control username"
           placeholder="账户/邮箱" required autofocus>
    <input name="password" value="" type="password" maxlength="18" class="form-control password" placeholder="密码"
           required>
    <input type="text" name="captcha" value="" class="form-control patchca" maxlength="4" placeholder="验证码"
           required><img
        class="captcha"
        src="/patchca?width=119&height=42&time=${.now?long}">

    <div class="error-box"></div>
    <label class="checkbox">
        <input type="checkbox" name="rememberMe" value="remember-me"> Remember me
    </label>

    <@shiro.isLoginFailure name="shiroLoginFailure">
        <div class="alert alert-danger" style="background-image: none;">
            <@shiro.loginException name="shiroLoginFailure"/>
        </div>
    </@shiro.isLoginFailure>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
</form>
</@layout>
<script type="text/javascript">
    $(function () {
        var signinform = $("#signin.form-signin");
        $("#signin button[type='submit']").click(function () {
            //表单验证
            var signinvalid = $.valid('#signin.form-signin', {
                rules: {"username": [
                    {regex: /^\w{5,18}$/}
                ], "password": [
                    {regex: /^\w{5,18}$/}
                ], "captcha": [
                    {regex: /^\d{4}$/}
                ]},
                messages: {
                    "username": {'regex': '用户名必须为5-18位英文字母 、数字和下划线'},
                    "password": {'regex': '密码必须为5-18位英文字母 、数字和下划线'},
                    "captcha": {'regex': '验证码必须为四位数字'}
                }, boxer: {exist: true}});

            if (signinvalid.validate()) {
                return true;
            }
            return false;
        });
    })
</script>