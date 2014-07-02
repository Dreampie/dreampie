<#include "/view/layout/_layout.ftl"/>
<@layout activebar="index" html_title=i18n.getText("notice.name")>
<p>您好,${user.full_name}</p>


<p>
    您的邮件以发送到：${user.email},请尽快到邮箱验证。
</p>
</@layout>