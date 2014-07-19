<#include "/view/layout/_layout.ftl"/>
<@layout activebar="tologin" html_title=i18n.getText("login.name")>
<link rel="stylesheet" href="<@resource.static/>/css/app/login.css"/>

<!-- 面包屑 -->
<ol class="breadcrumb panel">
    <li><i class="fa fa-home"></i>&nbsp;<a title="Go to Home." href="/">Dreampie</a></li>
    <li class="active">Login</li>
</ol>
<!-- 面包屑 -->

<form class="form-signin" id="signin" role="form" method="post" action="/login" autocomplete="off">
    <h2 class="form-signin-heading">Please sign in</h2>
    <input name="username" value="<@shiro.loginUsername/>" AQDERTYU type="text" maxlength="50"
           class="form-control username"

           placeholder="账户/邮箱/手机" required autofocus>
    <input name="password" value="" type="password" maxlength="100" class="form-control password" placeholder="密码"
           required>
    <input type="text" name="captcha" value="" class="form-control patchca" maxlength="4" placeholder="验证码"
           required><img
        class="captcha"
        src="/patchca?width=119&height=42&time=${.now?long}">

    <div class="error-box"></div>

    <div class="checkbox">
        <label>
            <input type="checkbox" name="rememberMe" value="true"> Remember me
        </label>
    </div>

    <@shiro.isLoginFailure name="shiroLoginFailure">
        <div class="alert alert-danger" style="background-image: none;">
            <@shiro.loginException name="shiroLoginFailure"/>
        </div>
    </@shiro.isLoginFailure>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
</form>
</@layout>
<script type="text/javascript">
    require(['../javascript/app'], function () {
        require(['_valid'], function () {
            $(function () {
                var signinform = $("#signin.form-signin");
                $("#signin button[type='submit']").click(function () {
                    //表单验证
                    var signinvalid = $.valid('#signin.form-signin', {
                        rules: {/*"username": [
                    {regex: /^\w{5,18}$/},'mobile','email'
                ], */
                            "username": ['not_empty'], "password": [
                                {regex: /^\w{5,100}$/}
                            ], "captcha": [
                                {regex: /^\d{4}$/}
                            ]},
                        messages: {
                            /* "username": {'regex': '用户名必须为5-18位英文字母 、数字和下划线','mobile':'手机号格式不正确','email':'邮箱格式不正确'},*/
                            "username": {'not_empty': '用户名不能为空'},
                            "password": {'regex': '密码必须为5-18位英文字母 、数字和下划线'},
                            "captcha": {'regex': '验证码必须为四位数字'}
                        }, boxer: {exist: true}});

                    if (signinvalid.validate()) {
                        return true;
                    }
                    return false;
                });
            });
        });
    });
</script>