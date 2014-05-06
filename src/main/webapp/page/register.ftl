<#include "/page/layout/_layout.ftl"/>
<@layout activebar="register" html_title=i18n.getText("register.name")>
<link rel="stylesheet" href="<@resource.static/>/css/register.css"/>
<script type="text/javascript" src="<@resource.static/>/js/layout/jquery.form.js"></script>
<script type="text/javascript" src="<@resource.static/>/js/layout/_valid.js"></script>
<form class="form-horizontal form-register" id="register" role="form" method="post" action="/register" autocomplete="off">
  <h2 class="form-register-heading">Please register</h2>

  <input name="user.username" value="${(user.username)!}" type="text" maxlength="18" class="form-control username" placeholder="账户" required autofocus>
  <input name="user.password" value="" type="password" maxlength="18" class="form-control password" placeholder="密码" required>
  <input name="repassword" value="" type="password" maxlength="18" class="form-control password" placeholder="重复密码" required>
  <input name="user.email" value="${(user.email)!}" type="text" maxlength="200" class="form-control email" placeholder="邮箱">
  <input name="user.last_name" value="${(user.last_name)!}" type="text" maxlength="10" class="form-control last_name" placeholder="姓">
  <input name="user.first_name" value="${(user.first_name)!}" type="text" maxlength="10" class="form-control fisrt_name" placeholder="名">
  <input type="text" name="captcha" value="" class="form-control patchca" maxlength="4" placeholder="验证码" required><img
    class="captcha"
    src="/patchca?width=119&height=42">

  <div class="error-box">
    <#if usernameMsg??>
    ${usernameMsg}<br/>
    </#if>
    <#if passwordMsg??>
    ${passwordMsg}<br/>
    </#if>
    <#if repasswordMsg??>
    ${repasswordMsg}<br/>
    </#if>
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
  <label class="checkbox">
    <input type="checkbox" name="autoLogin" value="true" checked="checked">Auto Login
  </label>
  <button class="btn btn-lg btn-primary btn-block" type="submit">Register</button>
</form>
</@layout>
<script type="text/javascript">
  $(function () {
    var registerform = $("#register.form-horizontal");
    $("#register button[type='submit']").click(function () {
      //表单验证
      var registervalid = $.valid('#register.form-register', {
        rules: {"user.username": [
          {regex: /^\w{5,18}$/}
        ], "user.first_name": [
          {"max_length": 10}
        ], "user.last_name": [
          {"max_length": 10}
        ], "user.password": [
          {regex: /^\w{5,18}$/}
        ], "repassword": [
          {matches: 'user.password'}
        ], "user.email": [
          {regex: /^(((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))?$/i}
        ], "captcha": [
          {regex: /^\d{4}$/}
        ]},
        messages: {
          "user.username": {'regex': '用户名必须为5-18位英文字母 、数字和下划线'},
          "user.first_name": {'max_length': '名字长度不能超过10位'},
          "user.last_name": {'max_length': '姓氏长度不能超过10位'},
          "user.password": {'regex': '密码必须为5-18位英文字母 、数字和下划线'},
          "repassword": {'matches': '重复密码不匹配'},
          "user.email": {'regex': '邮箱格式不正确'},
          "captcha": {'regex': '验证码必须为四位数字'}
        }, boxer: {exist: true}});
      if (registervalid.validate()) {
        return true;
      }
      return false;
    });
  })
</script>