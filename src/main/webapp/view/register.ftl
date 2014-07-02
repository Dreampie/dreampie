<#include "/view/layout/_layout.ftl"/>
<@layout activebar="toregister" html_title=i18n.getText("register.name")>
<link rel="stylesheet" href="<@resource.static/>/css/register.css"/>
<script type="text/javascript" src="<@resource.static/>/javascript/layout/jquery.form.js"></script>
<script type="text/javascript" src="<@resource.static/>/javascript/layout/_valid.js"></script>
<form class="form-horizontal form-register" id="register" role="form" method="post" action="/register" autocomplete="off">
  <h2 class="form-register-heading">Please register</h2>

  <input name="user.username" value="${(user.username)!}" type="text" maxlength="18" class="form-control username" placeholder="账户" required autofocus>
  <input name="user.password" value="" type="password" maxlength="18" class="form-control password" placeholder="密码" required>
  <input name="repassword" value="" type="password" maxlength="18" class="form-control password" placeholder="重复密码" required>
  <input name="user.last_name" value="${(user.last_name)!}" type="text" maxlength="10" class="form-control last_name" placeholder="姓">
  <input name="user.first_name" value="${(user.first_name)!}" type="text" maxlength="10" class="form-control fisrt_name" placeholder="名">

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
    <#if firstnameMsg??>
    ${firstnameMsg}<br/>
    </#if>
    <#if lastnameMsg??>
    ${lastnameMsg}<br/>
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
            'not_empty',{"max_length": 10}
        ], "user.last_name": [
            'not_empty',{"max_length": 10}
        ], "user.password": [
          {regex: /^\w{5,18}$/}
        ], "repassword": [
          {matches: 'user.password'}
        ]},
        messages: {
          "user.username": {'regex': '用户名必须为5-18位英文字母 、数字和下划线'},
          "user.first_name": {'not_empty': '名字不能为空','max_length': '名字长度不能超过10位'},
          "user.last_name": {'not_empty': '姓氏不能为空','max_length': '姓氏长度不能超过10位'},
          "user.password": {'regex': '密码必须为5-18位英文字母 、数字和下划线'},
          "repassword": {'matches': '重复密码不匹配'}
        }, boxer: {exist: true}});
      if (registervalid.validate()) {
        return true;
      }
      return false;
    });
  })
</script>