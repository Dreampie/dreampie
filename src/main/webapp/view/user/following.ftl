<#include "/view/layout/_layout.ftl"/>
<#include "/view/layout/_pagination.ftl" />
<@layout activebar="following" html_title=i18n.getText("user.follower")>

<!-- 面包屑 -->
<ol class="breadcrumb panel">
    <li><i class="fa fa-home"></i>&nbsp;<a title="Go to Home." href="/">Dreampie</a></li>
    <li><a title="Go to User." href="/user">User</a></li>
    <li class="active">Following</li>
</ol>
<!-- 面包屑 -->

<div class="row">
    <div class="col-md-4 searchline">
        <form id="user_search" class="searchbar " role="form" action="/user/following" method="get"
              data-view="searchbar" data-classname="col-sm-4"
              data-inputclass="form-control" data-placeholder="姓名，电话，地址等">
            <span style=" position: relative; ">
                <input class="tt-hint" type="text" autocomplete="off" spellcheck="off" disabled="" >
                <input name="user_search" type="text" value="${(user_search)!}" placeholder="姓名，电话，地址等"
                       class="form-control tt-query"
                       spellcheck="false" maxlength="20"
                       dir="auto" style="/* position: relative; */vertical-align: top;background-color: transparent;">
                <span class="tt-dropdown-menu"
                      style="position: absolute; top: 100%; left: 0px; z-index: 100; display: none;"></span>
            </span>
            <button type="submit" class="glyphicon glyphicon-search search"></button>
        <#--<div class="error-box">${user_searchMsg!}</div>-->
        </form>

    <#--<form id="user_search" class="form-inline" role="form" action="/user/follower" method="get">-->
    <#--<div class="form-group">-->
    <#--<label class="sr-only" for="user_search">姓名，电话，地址等</label>-->
    <#--<input type="text" class="form-control" id="user_search" maxlength="8" name="user_search"-->
    <#--value="${(user_search)!}" placeholder="关键字"/>-->

    <#--</div>-->

    <#--<button type="submit" class="btn btn-default search"><i class="glyphicon glyphicon-search"></i>搜索</button>-->
    <#--</form>-->
    </div>
</div>

<div class="row">

    <#if users?? && users?size gt 0>
        <#list userGroup.keySet() as wordkey>
            <#if userGroup.get(wordkey)?? && userGroup.get(wordkey)?size gt 0>
                <div class="container-fluid">
                    Group ${wordkey}
                </div>
                <#list userGroup.get(wordkey) as user>
                    <div class="col-sm-6 col-md-4">
                        <div class="media thumbnail user">
                            <a class="pull-left" href="#">
                                <#if !user.avatar_url?? || user.avatar_url==''>
                                    <#assign avatar_url='/image/app/avatar.jpg'/>
                                </#if>
                                <img class="media-object lazy" style="width: 120px;"
                                     src="${avatar_url!user.avatar_url}"
                                     data-src="${avatar_url!user.avatar_url}">
                            </a>

                            <div class="media-body f12" style="word-wrap: break-word；word-break:break-all;">
                                <h4 class="media-heading">${(user.full_name)!}
                                    <br/>
                                    <small><span style="font-size: 11px;">
                                        ${(user.username)!}&nbsp;
                                            <#if user.gender??>
                                                <#if user.gender==0>
                                                    男
                                                <#elseif user.gender==1>
                                                    女
                                                </#if>
                                            </#if><br/>
                                        ${(user.province)!}&nbsp;${(user.city)!}&nbsp;${(user.county)!}
                                            &nbsp;${(user.street)!}
                                    </span>
                                    </small>
                                </h4>
                            ${(user.intro)!}
                                <br/>
                            ${(user.mobile)!}
                                <br/>
                            ${(user.email)!}
                                <br/>
                            ${(user.created_at?string('yyyy-MM-dd HH:mm:ss'))!}
                                <br/>
                                <#assign username=user.full_name+"("+user.username+")"/>
                                <button type="button" class="btn btn-danger btn-xs" data-toggle="modal"
                                        data-target="#del_following"
                                        followerid="${user.id}" username="${username}">取消
                                </button>
                                <button type="button" class="btn btn-default btn-xs" data-toggle="modal"
                                        data-target="#upd_intro"
                                        followerid="${user.id}" username="${username}" intro="${(user.intro)!}">备注
                                </button>
                            </div>
                        </div>
                    </div>
                </#list>
            </#if>
        </#list>
    </#if>
</div>
<div class="row">
    <div class="col-sm-6 col-md-4 ">
        <#if users?? && users?size gt 0>
        <@pagination currentPage=users.pageNumber totalPage=users.totalPage actionUrl=_localUri urlParas=_localParas className="pagination"/>
    </#if>
    </div>
</div>
</@layout>

<#include "/view/user/_del_following_modal.ftl" />
<#include "/view/user/_upd_intro_modal.ftl" />

<script type="text/javascript">
    require(['../../javascript/app'], function () {
        require(['jquery'], function () {
            $(function () {
//        $("#user_search.form button.search").click(function () {
//            //表单验证
//            var searchvalid = $.valid('#user_search', {
//                wrapper: "div.form-group",
//                rules: {"user_search": [
//                    "not_empty"
//                ]},
//                messages: {
//                    "user_search": {'not_empty': '搜索框不能为空'}
//                }});
//
//            if (searchvalid.validate()) {
//                return true;
//            }
//            return false;
//        });
                $("div.user button").click(function () {
                    var opbtn = $(this);
                    var del_following = "#del_following";
                    var upd_intro = "#upd_intro";
                    //装配数据
                    $("div.modal div[name='username']").text(opbtn.attr("username"));
                    if (opbtn.attr("data-target") == del_following) {
                        $(del_following + " input[name='follower.id']").val(opbtn.attr("followerid"));
                    } else if (opbtn.attr("data-target") == upd_intro) {
                        $(upd_intro + " input[name='follower.id']").val(opbtn.attr("followerid"));
                        $(upd_intro + " textarea[name='follower.intro']").val(opbtn.attr("intro"));
                    }

                });
            });
        });
    });
</script>