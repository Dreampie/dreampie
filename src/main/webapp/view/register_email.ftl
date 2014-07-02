<#include "/view/layout/_layout.ftl"/>
<@layout activebar="toregister" html_title=i18n.getText("register.name")>
<link rel="stylesheet" href="<@resource.static/>/css/register.css"/>
<script type="text/javascript" src="<@resource.static/>/javascript/layout/jquery.form.js"></script>
<script type="text/javascript" src="<@resource.static/>/javascript/layout/_valid.js"></script>
<form class="form-horizontal form-register" id="register_email" role="form" method="post" action="/registerEmail" autocomplete="off">
    <h2 class="form-register-heading">Please write email</h2>

    <input name="user.email" value="${(user.email)!}" type="text" maxlength="200" class="form-control email" placeholder="邮箱">
    <input name="user.last_name" value="${(user.last_name)!}" type="text" maxlength="10" class="form-control last_name" placeholder="姓">
    <input name="user.first_name" value="${(user.first_name)!}" type="text" maxlength="10" class="form-control fisrt_name" placeholder="名">
    <input type="text" name="captcha" value="" class="form-control patchca" maxlength="4" placeholder="验证码" required><img
        class="captcha"
        src="/patchca?width=119&height=42">

    <div class="error-box">
        <#if emailMsg??>
            ${emailMsg}<br/>
        </#if>
        <#if firstnameMsg??>
            ${firstnameMsg}<br/>
        </#if>
        <#if lastnameMsg??>
            ${lastnameMsg}<br/>
        </#if>
        <#if captchaMsg??>
        ${captchaMsg}
        </#if>
    </div>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Send</button>
</form>
</@layout>
<script type="text/javascript">
    $(function () {
        var registerform = $("#register_email.form-horizontal");
        $("#register_email button[type='submit']").click(function () {
            //表单验证
            var registervalid = $.valid('#register_email.form-register', {
                rules: {"user.username": [
                    {regex: /^\w{5,18}$/}
                ], "user.first_name": [
                    'not_empty', {"max_length": 10}
                ], "user.last_name": [
                    'not_empty', {"max_length": 10}
                ], "user.email": [
                    'email'
                ], "captcha": [
                    {regex: /^\d{4}$/}
                ]},
                messages: {
                    "user.first_name": {'not_empty': '名字不能为空', 'max_length': '名字长度不能超过10位'},
                    "user.last_name": {'not_empty': '姓氏不能为空', 'max_length': '姓氏长度不能超过10位'},
                    "user.email": {'email': '邮箱格式不正确'},
                    "captcha": {'regex': '验证码必须为四位数字'}
                }, boxer: {exist: true}});
            if (registervalid.validate()) {
                return true;
            }
            return false;
        });
    })
</script>