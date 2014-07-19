<#include "/view/layout/_layout.ftl"/>
<#include "/view/layout/_pagination.ftl" />
<@layout activebar="search" html_title=i18n.getText("app.search")>

<!-- 面包屑 -->
<ol class="breadcrumb panel">
    <li><i class="fa fa-home"></i>&nbsp;<a title="Go to Home." href="/">Dreampie</a></li>
    <li><a title="Go to User." href="/user">User</a></li>
    <li class="active">Search</li>
</ol>
<!-- 面包屑 -->

<div class="row">
    <div class="col-md-4 searchline">
        <form id="user_search" class="searchbar " role="form" action="/user/search" method="get" data-view="searchbar"
              data-classname="col-sm-4"
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

                            <div class="media-body f12" style="word-wrap: break-word;word-break:break-all;">
                                <h4 class="media-heading">${(user.full_name)!}
                                    <br>
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
                                    </span>
                                    </small>

                                </h4>
                                <#assign username=user.full_name+"("+user.username+")"/>
                                <#if user.followed?? && user.followed?string('true','false')=='true'>
                                ${(user.following.intro)!}
                                    <br/>
                                ${(user.mobile)!}
                                    <br/>
                                ${(user.email)!}
                                    <br/>
                                ${(user.created_at?string('yyyy-MM-dd HH:mm:ss'))!}
                                    <br/>
                                    <button type="button" class="btn btn-danger btn-xs" data-toggle="modal"
                                            data-target="#del_following"
                                            followerid="${user.following.id}" username="${username}">取消
                                    </button>
                                <#else>
                                    <#if user.mobile?? && user.mobile?length==11>
                                    ${user.mobile?substring(0,3)+"****"+user.mobile?substring(7)}
                                    </#if>
                                    <br/>
                                    <#if user.email?? && user.email?length gt 0>
                                        <#assign ixe=user.email?index_of("@")/>
                                    ${user.email?substring(0,2)+"***"+user.email?substring(ixe)}
                                    </#if>
                                    <br/>
                                ${(user.created_at?string('yyyy-MM-dd HH:mm:ss'))!}
                                    <br/>
                                    <button type="button" class="btn btn-danger btn-xs" data-toggle="modal"
                                            data-target="#add_following"
                                            linkid="${user.id}" username="${username}">关注
                                    </button>
                                </#if>
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
<#include "/view/user/_add_following_modal.ftl" />
<#include "/view/user/_del_following_modal.ftl" />

<script type="text/javascript">
    require(['../../javascript/app'], function () {
        require(['jquery'], function () {
            $(function () {
                $("div.user button").click(function () {
                    var opbtn = $(this);
                    var add_following = "#add_following";
                    var del_following = "#del_following";
                    //装配数据
                    $("div.modal div[name='username']").text(opbtn.attr("username"));
                    if (opbtn.attr("data-target") == add_following) {
                        $(add_following + " input[name='follower.link_id']").val(opbtn.attr("linkid"));
                    } else if (opbtn.attr("data-target") == del_following) {
                        $(del_following + " input[name='follower.id']").val(opbtn.attr("followerid"));
                    }

                });
            });
        });
    });
</script>