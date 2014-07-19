<#include "/view/layout/_layout.ftl"/>
<#include "/view/layout/_pagination.ftl" />
<@layout activebar="user" html_title=i18n.getText("admin.user")>

<!-- 面包屑 -->
<ol class="breadcrumb panel">
    <li><i class="fa fa-home"></i>&nbsp;<a title="Go to Home." href="/">Dreampie</a></li>
    <li><a title="Go to Admin." href="/admin">Admin</a></li>
    <li class="active">User</li>
</ol>
<!-- 面包屑 -->

<div class="row">
    <div class="col-md-4 searchline">
        <form id="user_search" class="searchbar " role="form" action="/admin/user" method="get" data-view="searchbar"
              data-classname="col-sm-4"
              data-inputclass="form-control" data-placeholder="用户名，姓名，电话，地址等">
            <span class="twitter-typeahead" style=" position: relative; ">
                <input class="tt-hint" type="text" autocomplete="off" spellcheck="off" disabled="">
                <input name="user_search" type="text" value="${(user_search)!}" placeholder="用户名，姓名，电话，地址等"
                       class="form-control tt-query"
                       required="" autocomplete="off"
                       spellcheck="false" maxlength="20"
                       dir="auto" style="/* position: relative; */vertical-align: top;background-color: transparent;">
                <span class="tt-dropdown-menu"
                      style="position: absolute; top: 100%; left: 0px; z-index: 100; display: none;"></span>
            </span>
            <button type="submit" class="glyphicon glyphicon-search search"></button>
        <#--<div class="error-box">${user_searchMsg!}</div>-->
        </form>

    <#--<form id="user_search" class="form-inline" role="form" action="/admin/user" method="get">
        <div class="form-group">
            <label class="sr-only" for="user_search">用户名，姓名，电话，地址等</label>
            <input type="text" class="form-control" id="user_search" maxlength="8" name="user_search"
                   value="${(user_search)!}" placeholder="关键字"/>

        </div>

        <button type="submit" class="btn btn-default search"><i class="glyphicon glyphicon-search"></i>搜索</button>
    </form>-->
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
                                    <#assign avatar_url='/image/avatar.jpg'/>
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
                                            <#if roles?? && roles?size gt 0>
                                                <#list roles as role>
                                                    <#if role.id==user.role_id>
                                                        <#assign rolename=role.name/>
                                                    ${rolename}
                                                    </#if>
                                                </#list>
                                            </#if>
                                            &nbsp;
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
                            ${(user.mobile)!}<br/>
                            ${(user.email)!}
                                <br/>
                            ${(user.created_at?string('yyyy-MM-dd HH:mm:ss'))!}
                                <br/>
                                <#assign username=user.full_name+"("+user.username+")"/>
                                <#if user.deleted_at??>
                                    <button type="button" class="btn btn-danger btn-xs" data-toggle="modal"
                                            data-target="#del_user"
                                            userid="${user.id}" username="${username}" deletedat="">启用
                                    </button>
                                <#else>
                                    <button type="button" class="btn btn-danger btn-xs" data-toggle="modal"
                                            data-target="#del_user"
                                            userid="${user.id}" username="${username}" deletedat="${.now}">删除
                                    </button>
                                </#if>
                                <button type="button" class="btn btn-default btn-xs" data-toggle="modal"
                                        data-target="#upd_role"
                                        userid="${user.id}" username="${username}" roleid="${user.role_id}"
                                        rolename="${rolename}">角色
                                </button>
                                <button type="button" class="btn btn-default btn-xs" data-toggle="modal"
                                        data-target="#upd_pwd"
                                        userid="${user.id}" username="${username}">密码
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

<!-- Modal -->
<div class="modal fade" id="del_user" tabindex="-1" role="dialog" aria-labelledby="del_userModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="del_userModalLabel">删除</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="/admin/deleteUser">
                    <input type="hidden" name="user.id" value="">
                    <input type="hidden" name="user.deleted_at" value="">

                    <div class="form-group">
                        <label class="col-sm-3 textright">账户:</label>

                        <div class="col-sm-9" name="username"></div>
                    </div>
                    <div class="error-box"></div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary del_user" data-loading-text="正在删除..."
                        data-complete-text="删除成功!">删除
                </button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- Modal -->
<div class="modal fade" id="upd_role" tabindex="-1" role="dialog" aria-labelledby="upd_roleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="upd_roleModalLabel">修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="/admin/deleteUser">
                    <input type="hidden" name="userRole.user_id" value="">

                    <div class="form-group">
                        <label class="col-sm-3 textright">账户:</label>

                        <div class="col-sm-9" name="username"></div>
                    </div>
                <#if roles?? && roles?size gt 0>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">角色:</label>

                        <div class="col-sm-9" name="role">
                            <div class="btn-group">
                                <input type="hidden" class="selection" name="userRole.role_id"
                                       value="">
                                <button class="btn btn-default dropdown-toggle" type="button"
                                        data-toggle="dropdown">
                                    <span class="selection">角色</span> <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu">
                                    <#list roles as role>
                                        <li><a href="#" value="${role.id}">${role.name}</a>
                                        </li>
                                    </#list>
                                    <li class="divider"></li>
                                    <li><a href="#" value="">取消</a></li>
                                </ul>
                            </div>

                        </div>
                    </div>
                </#if>
                    <div class="error-box"></div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary upd_role" data-loading-text="正在保存..."
                        data-complete-text="保存成功!">保存
                </button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- Modal -->
<div class="modal fade" id="upd_pwd" tabindex="-1" role="dialog" aria-labelledby="upd_pwdModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="upd_pwdModalLabel">修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="/admin/updateUser">
                    <input type="hidden" name="user.id" value="">

                    <div class="form-group">
                        <label class="col-sm-3 textright">账户:</label>

                        <div class="col-sm-9" name="username"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">密码:</label>

                        <div class="col-sm-9" name="password">

                            <!-- Nav tabs -->
                            <ul class="nav nav-tabs">
                                <li class="active"><a id="writeA" href="#write" data-toggle="tab">自定义输入</a></li>
                                <li><a id="autoA" href="#auto" data-toggle="tab">自动生成</a></li>
                            </ul>

                            <!-- Tab panes -->
                            <div class="tab-content">
                                <div class="tab-pane fade in active" id="write">
                                    <input type="password" style="margin-top: 15px;" class="form-control"
                                           maxlength="200"
                                           name="user.password"
                                           value="" placeholder="密码">

                                    <input type="password" style="margin-top: 15px;"
                                           class="form-control"
                                           maxlength="200"
                                           name="repassword"
                                           value=""
                                           placeholder="重复密码">


                                </div>
                                <div class="tab-pane fade" id="auto">
                                    <div style="margin-top: 15px;">
                                        <span></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="error-box"></div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary upd_pwd" data-loading-text="正在保存..."
                        data-complete-text="保存成功!">保存
                </button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
    require(['../../javascript/app'], function () {
        require(['_valid'], function () {
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
                //自动生产密码
                $("#autoA").click(function () {
                    var upd_pwd = "#upd_pwd";
                    var randPwd = randomNum(5);
                    $(upd_pwd + " #auto span").text(randPwd);
                    $(upd_pwd + " input[name='user.password']").val(randPwd);
                    $(upd_pwd + " input[name='repassword']").val(randPwd);
                });

                $("#writeA").click(function () {
                    var upd_pwd = "#upd_pwd";
                    $(upd_pwd + " #auto span").text("");
                    $(upd_pwd + " input[name='user.password']").val("");
                    $(upd_pwd + " input[name='repassword']").val("");
                });

                $("div.user button").click(function () {
                    var opbtn = $(this);
                    var del_user = "#del_user";
                    var upd_role = "#upd_role";
                    var upd_pwd = "#upd_pwd";
                    //装配数据
                    $("div.modal div[name='username']").text(opbtn.attr("username"));
                    if (opbtn.attr("data-target") == del_user) {
                        $(del_user + " input[name='user.id']").val(opbtn.attr("userid"));
                        $(del_user + " input[name='user.deleted_at']").val(opbtn.attr("deletedat"));
                        var optext = $.trim(opbtn.text());
                        $("#del_userModalLabel").text(optext);
                        $(del_user + " button.del_user").text(optext);
                        $(del_user + " button.del_user").attr("data-loading-text", "正在" + optext + "...");
                        $(del_user + " button.del_user").attr("data-complete-text", optext + "成功");
                    } else if (opbtn.attr("data-target") == upd_role) {
                        $(upd_role + " input[name='userRole.user_id']").val(opbtn.attr("userid"));
                        $(upd_role + " input[name='userRole.role_id']").val(opbtn.attr("roleid"));
                        $(upd_role + " div.btn-group span.selection").text(opbtn.attr("rolename"));
                    } else if (opbtn.attr("data-target") == upd_pwd) {
                        $(upd_pwd + " input[name='user.id']").val(opbtn.attr("userid"));

                    }

                });

                //删除用户
                var del_userbtn = $("#del_user.modal button.del_user");
                del_userbtn.click(function () {
                    var btn = $(this);
                    var form = $("#del_user.modal form");
                    //表单验证
                    var del_uservalid = $.valid('#del_user.modal form', {
                        wrapper: "div.form-group",
                        rules: {
                            "user.id": [
                                {regex: /^\d+$/}
                            ]},
                        messages: {
                            "user.id": {'regex': '账号参数异常'}
                        }, boxer: {exist: true}});

                    if (del_uservalid.validate()) {
                        btn.button('loading');
                        $.post("/admin/deleteUser", form.serialize(), function (data) {
                            if (data.state == "success") {
                                btn.button('complete');
                                setTimeout(function () {
                                    btn.button('reset');
                                    window.location.reload();
                                }, 1000)
                            } else {
                                var errors = "";
                                errors = checkError(errors, data.user_idMsg);
                                form.find("div.error-box").html(errors);
                                btn.button('reset');
                            }
                        }, "json").error(function () {
                            btn.button('reset');
                        });
                    }
                });

                //修改角色
                var upd_rolebtn = $("#upd_role.modal button.upd_role");
                upd_rolebtn.click(function () {
                    var btn = $(this);
                    var form = $("#upd_role.modal form");
                    //表单验证
                    var upd_rolevalid = $.valid('#upd_role.modal form', {
                        wrapper: "div.form-group",
                        rules: {
                            "userRole.user_id": [
                                {regex: /^\d+$/}
                            ], "userRole.role_id": [
                                {regex: /^\d+$/}
                            ]},
                        messages: {
                            "userRole.user_id": {'regex': '账号参数异常'},
                            "userRole.role_id": {'regex': '角色参数异常'}
                        }, boxer: {exist: true}});

                    if (upd_rolevalid.validate()) {
                        btn.button('loading');
                        $.post("/admin/updateRole", form.serialize(), function (data) {
                            if (data.state == "success") {
                                btn.button('complete');
                                setTimeout(function () {
                                    btn.button('reset');
                                    window.location.reload();
                                }, 1000)
                            } else {
                                var errors = "";
                                errors = checkError(errors, data.user_idMsg);
                                errors = checkError(errors, data.role_idMsg);
                                form.find("div.error-box").html(errors);
                                btn.button('reset');
                            }
                        }, "json").error(function () {
                            btn.button('reset');
                        });
                    }
                });
                //修改密码
                var upd_pwdbtn = $("#upd_pwd.modal button.upd_pwd");
                upd_pwdbtn.click(function () {
                    var btn = $(this);
                    var form = $("#upd_pwd.modal form");
                    //表单验证
                    var upd_pwdvalid = $.valid('#upd_pwd.modal form', {
                        wrapper: "div.form-group",
                        rules: {"user.id": [
                            {regex: /^\d+$/}
                        ], "user.password": [
                            {regex: /^(\w{5,18})?$/}
                        ], "repassword": [
                            {matches: 'user.password'}
                        ]},
                        messages: {
                            "user.id": {'regex': '账号参数异常'},
                            "user.password": {'regex': '密码为英文字母 、数字和下划线长度为5-18'},
                            "repassword": {'matches': '重复密码不一致'}
                        }, boxer: {exist: true}});

                    if (upd_pwdvalid.validate()) {
                        btn.button('loading');
                        $.post("/admin/updatePwd", form.serialize(), function (data) {
                            if (data.state == "success") {
                                btn.button('complete');
                                setTimeout(function () {
                                    btn.button('reset');
                                    window.location.reload();
                                }, 1000)
                            } else {
                                var errors = "";
                                errors = checkError(errors, data.user_idMsg);
                                errors = checkError(errors, data.user_passwordMsg);
                                form.find("div.error-box").html(errors);
                                btn.button('reset');
                            }
                        }, "json").error(function () {
                            btn.button('reset');
                        });
                    }
                });
            });
        });
    });
</script>