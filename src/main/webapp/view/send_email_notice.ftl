<#include "/view/layout/_layout.ftl"/>
<@layout activebar="index" html_title=i18n.getText("notice.name")>

<p class="page-header">您好,先生/女士</p>


<p>
    您的邮件已发送到：<a target="_blank" href="https://mail.${user.email?split("@")[1]}">${user.email}</a>,请尽快到邮箱验证进行下一步。
</p>
</@layout>