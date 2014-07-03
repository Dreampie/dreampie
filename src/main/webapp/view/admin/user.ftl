<#include "/view/layout/_layout.ftl"/>
<#include "/view/layout/_pagination.ftl" />
<@layout activebar="user" html_title=i18n.getText("admin.user")>
<script type="text/javascript" src="<@resource.static/>/javascript/layout/jquery.form.js"></script>
<script type="text/javascript" src="<@resource.static/>/javascript/layout/_valid.js"></script>

<div class="row">
    <div class="col-md-12">
        <p>

        <form id="user_search" class="form-inline" role="form" action="/admin/user" method="get">
            <div class="form-group">
                <label class="sr-only" for="user_search">用户名，姓名，电话，地址等</label>
                <input type="text" class="form-control" id="user_search" maxlength="8" name="user_search"
                       value="${(user_search)!}" placeholder="关键字"/>

            </div>

            <button type="submit" class="btn btn-default search">搜索</button>
        </form>
        </p>
    </div>
</div>
<div class="row">
    <div class="col-md-12" role="main">
        <div class="panel panel-default">
            <div class="panel-heading">用户</div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th width="4%">编号</th>
                            <th width="10%">用户名</th>
                            <th width="18%">姓名/地址</th>
                            <th width="15%">电话</th>
                            <th width="20%">使用时间</th>
                            <th width="9%">状态</th>
                            <th width="12%">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                            <#if users?? && users?size gt 0>
                                <#list userGroup.keySet() as wordkey>
                                <tr>
                                    <td colspan="7">Group ${wordkey}</td>
                                </tr>
                                    <#if userGroup.get(wordkey)?? && userGroup.get(wordkey)?size gt 0>
                                    1
                                        <#list userGroup.get(wordkey) as user>
                                        <tr>
                                            <td>${user.id}</td>
                                            <td>${(user.username)!}
                                                <#if roles?? && roles?size gt 0>
                                                    <#list roles as role>
                                                        <#if role.id==user.role_id>
                                                            <hr style="margin: 1px;border-top: 1px solid #BBB754 !important;"/>
                                                            <span style="font-size: 11px;">${role.name}</span>
                                                        </#if>
                                                    </#list>
                                                </#if>
                                            </td>
                                            <td>${(user.full_name)!}
                                                <hr style="margin: 1px;border-top: 1px solid #BBB754 !important;"/>
                                            ${(user.province)!}&nbsp;${(user.city)!}&nbsp;${(user.county)!}
                                                <hr style="margin: 1px;border-top: 1px solid #BBB754 !important;"/>
                                            ${(user.address)!}
                                            </td>
                                            <td>${(user.mobile)!}</td>
                                            <td>${(user.create_at)!}</td>
                                            <td>
                                                <#if user.deleted_at??>
                                                    已删除
                                                <#else>
                                                    在使用
                                                </#if>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;<a class="btn btn-primary operate" data-toggle="modal"
                                                               href="#user_update" userid="${user.id}"
                                                               roleid="${user.role_id}"
                                                               username="${user.username}"
                                                               userdeleted="${(user.deleted_at)!}">修改</a>
                                            </td>
                                        </tr>
                                        </#list>
                                    </#if>
                                </#list>
                            </#if>
                        </tbody>
                    </table>
                    <#if users?? && users?size gt 0>
                        <@paginate currentPage=users.pageNumber totalPage=users.totalPage actionUrl=localUri urlParas=localParas className="pagination"/>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</div>
</@layout>

<!-- Modal -->
<div class="modal fade" id="user_update" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="/user/update">
                    <input type="hidden" name="user.id" value="">
                    <input type="hidden" name="user.username" value="">

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">账户:</label>

                                <div class="col-sm-9" name="user"></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">姓名:</label>

                                <div class="col-sm-9" name="name"></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
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
                                                   value="${(user.password)!}" placeholder="密码">

                                            <input type="password" style="margin-top: 15px;"
                                                   class="form-control"
                                                   maxlength="200"
                                                   name="repassword"
                                                   value="${(repassword)!}"
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
                        </div>
                    </div>
                <#if roles?? && roles?size gt 0>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">角色:</label>

                                <div class="col-sm-9" name="role">
                                    <div class="btn-group">
                                        <input type="hidden" class="selection" name="role_id"
                                               value="${(user.role_id)!}">
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
                        </div>
                    </div>
                </#if>
                    <div class="error-box"></div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary update" data-loading-text="正在保存..."
                        data-complete-text="保存成功!">保存
                </button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div><!-- /.modal -->
<script type="application/javascript">
    $(function () {
        $("#user_search.form button.search").click(function () {
            //表单验证
//            var ordervalid = $.valid('#user_search', {
//                wrapper: "div.form-group",
//                rules: {"user_search": [
//                    "not_empty"
//                ]},
//                messages: {
//                    "user_search": {'not_empty': '搜索框不能为空'}
//                }});
//
//            if (ordervalid.validate()) {
            return true;
//            }
//            return false;
        });

        $("#autoA").click(function () {
            var randPwd = randomNum(5);
            $("#user_update").find("#auto span").text(randPwd);
            $("#user_update").find("input[name='user.password']").val(randPwd);
            $("#user_update").find("input[name='repassword']").val(randPwd);
        });

        $("#writeA").click(function () {
            $("#user_update").find("#auto span").text("");
            $("#user_update").find("input[name='user.password']").val("");
            $("#user_update").find("input[name='repassword']").val("");
        });
        //详情
        $("a.operate").click(function () {
            var href = $(this).attr("href");
            var id = $(this).attr("userid");
            var roleId = $(this).attr("roleid");
            $(href).find("input[name='user.id']").val(id);
            $(href).find("input[name='user.username']").val($(this).attr("user"));
            $(href).find("div[name='user']").text($(this).attr("user"));
            $(href).find("div[name='name']").text($(this).attr("username"));
            var roleDiv = $(href).find("div[name='role']");

            roleDiv.find("input.selection").val(roleId);
            roleDiv.find("span.selection").text(roleDiv.find("li>a[value='" + roleId + "']").text());

            $(href).find("#auto span").text("");
            $(href).find("input[name='user.password']").val("");
            $(href).find("input[name='repassword']").val("");
//
            var updatebtn = $(href).find("button.update");
            updatebtn.click(function () {
                var btn = $(this);
                var form = $("#user_update.modal").find("form");
                //表单验证
                var uservalid = $.valid('#user_update.modal form', {
                    wrapper: "div.form-group",
                    rules: {"user.password": [
                        {regex: /^(\w{5,18})?$/}
                    ],
                        "repassword": [
                            {matches: 'user.password'}
                        ],
                        "role_id": [
                            {regex: /^(\d+)?$/}
                        ]},
                    messages: {
                        "user.password": {'regex': '密码为英文字母 、数字和下划线长度为5-18'},
                        "repassword": {'matches': '重复密码不一致'},
                        "role_id": {'regex': '角色必须选择'}
                    }, boxer: {exist: true}});

                if (uservalid.validate()) {
                    $.post("/user/update", form.serialize(), function (data) {
                        if (data.state == "success") {
                            btn.button('complete');
                            setTimeout(function () {
                                btn.button('reset');
                                window.location.reload();
                            }, 1000)
                        } else {
                            var errors = "";
                            errors = checkError(errors, data.username_idMsg);
                            errors = checkError(errors, data.username_userMsg);
                            errors = checkError(errors, data.username_passwordMsg);
                            errors = checkError(errors, data.repasswordMsg);
                            errors = checkError(errors, data.role_idMsg);
                            form.find("div.error-box").html(errors);
                            btn.button('reset');
                        }
                    }, "json");
                }
            });
        });
        function checkError(errorStr, errorMsg) {
            if (typeof(errorMsg) != 'undefined' && errorMsg != 'undefined') {
                if (errorStr != "") {
                    errorStr += "<br/>";
                }
                return errorStr += errorMsg;
            } else {
                return errorStr;
            }
        }
    })
</script>