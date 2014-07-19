<#include "/view/layout/_layout.ftl"/>
<@layout activebar="tosignup" html_title=i18n.getText("signup.name")>
<link rel="stylesheet" href="<@resource.static/>/css/app/signup.css"/>

<!-- 面包屑 -->
<ol class="breadcrumb panel">
    <li><i class="fa fa-home"></i>&nbsp;<a title="Go to Home." href="/">Dreampie</a></li>
    <li class="active">SignupEmail</li>
</ol>
<!-- 面包屑 -->

<form class="form-horizontal form-signup" id="signup_email" role="form" method="post" action="/signupEmail"
      autocomplete="off">
    <h2 class="form-signup-heading">Please write email</h2>

    <input name="user.email" value="${(user.email)!}" type="text" maxlength="200" class="form-control email"
           placeholder="邮箱">
    <input type="text" name="captcha" value="" class="form-control patchca" maxlength="4" placeholder="验证码"
           required><img
        class="captcha"
        src="/patchca?width=119&height=42">

    <div class="error-box">
        <#if emailMsg??>
        ${emailMsg}<br/>
        </#if>
        <#if captchaMsg??>
        ${captchaMsg}
        </#if>
    </div>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Send</button>
</form>
</@layout>
<script type="text/javascript">
    require(['../javascript/app'], function () {
        require(['_valid'], function () {
            $(function () {
                var signupform = $("#signup_email.form-horizontal");
                $("#signup_email button[type='submit']").click(function () {
                    //表单验证
                    var signupvalid = $.valid('#signup_email.form-signup', {
                        rules: { "user.email": [
                            'email'
                        ], "captcha": [
                            {regex: /^\d{4}$/}
                        ]},
                        messages: {
                            "user.email": {'email': '邮箱格式不正确'},
                            "captcha": {'regex': '验证码必须为四位数字'}
                        }, boxer: {exist: true}});
                    if (signupvalid.validate()) {
                        return true;
                    }
                    return false;
                });
            });
        });
    });
</script>