<#include "/view/layout/_layout.ftl"/>
<#include "/view/layout/_treenav.ftl" />
<@layout activebar="role" html_title=i18n.getText("admin.role")>
<link rel="stylesheet" href="<@resource.static/>/css/layout/_treenav.css" type="text/css"/>

<!-- 面包屑 -->
<ol class="breadcrumb panel">
    <li><i class="fa fa-home"></i>&nbsp;<a title="Go to Home." href="/">Dreampie</a></li>
    <li><a title="Go to Admin." href="/admin">Admin</a></li>
    <li class="active">Role</li>
</ol>
<!-- 面包屑 -->

<div class="row">
    <div class="col-md-3">
        <div class="treenav">
            <@treenav nodes=rolestree attrs="name,value,intro,deleted_at"/>
      <#--<ul id="tree_role" class="ztree"></ul>-->
        </div>
    </div>
    <div class="col-md-9" role="main">
        <div class="panel panel-default">
            <div class="panel-heading">角色</div>
            <div class="panel-body">
                <#if role??>
                    <input type="hidden" name="current_role_id" value="${role.id}"/>
                <div class="row">
                    <div class="col-md-3">
                        <input type="hidden" name="node_id" value="${role.id}"/>
                        <label>名称:</label>

                        <div name="node_name">${role.name}</div>
                        <div name="node_key">${role.value}</div>
                    </div>
                    <div class="col-md-4">
                        <label>描述:</label>

                        <div name="node_intro">${(role.intro)!}</div>
                    </div>
                    <div class="col-md-1">
                        <input type="hidden" name="node_delete_at" value="${(role.delete_at)!}"/>
                        <label>状态:</label>

                        <div name="node_delete_at">
                        ${(role.delete_at)!"正常"}
                            <#if role.delete_at??>
                                已删除
                            </#if>
                        </div>
                    </div>
                </#if>
                <div class="col-md-4">
                    <label>操作:</label>

                    <div name="node_operation">
                        <a class="btn btn-primary save" role="button" data-toggle="modal" href="#role_save"
                           title="添加角色">添加</a>
                        <a class="btn btn-warning update" role="button" data-toggle="modal" href="#role_save"
                           title="修改角色信息">修改</a>
                        <a class="btn btn-danger hide delete" role="button" data-toggle="modal" href="#delete"
                           title="删除该角色">删除</a>
                    </div>
                </div>
            </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="page-header">
                            <h3 id="whats-included">
                                权限
                                <small class="operate"><a class="save" permid="0"
                                                          data-toggle="modal"
                                                          href="#perm_save">添加</a>(权限分为两级,角色以R_开始,权限以P_开始,权限目录以P_D_开始)
                                </small>
                            </h3>
                        </div>
                    </div>
                </div>
                <form id="role_perms" class="form-horizontal" role="form" action="/admin/role_perms">
                    <input type="hidden" name="role.id" value="">
                    <#if permissionestree?? && permissionestree?size gt 0>
                        <#list permissionestree as permission>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="page-header">
                                        <h4 id="whats-included">
                                            <label class="checkbox-inline">
                                                <input name="permission.id" id="perm${permission.id}" type="checkbox"
                                                       value="${permission.id}"> ${(permission.name)!}
                                                (${permission.value})&nbsp;&nbsp;
                                                <small class="operate"><a class="save" permid="${permission.id}"
                                                                          data-toggle="modal"
                                                                          href="#perm_save">添加</a>&nbsp;
                                                    <a class="update"
                                                       permid="${permission.id}"
                                                       permname="${permission.name}"
                                                       permintro="${permission.intro}"
                                                       permvalue="${permission.value}"
                                                       permurl="${permission.url}"
                                                       data-toggle="modal"
                                                       href="#perm_save">修改</a>&nbsp;
                                                    <#if permission.children?exists && permission.children?size lte 0>
                                                        <a permid="${permission.id}" data-toggle="modal" class="delete"
                                                           href="#delete">删除</a>
                                                    </#if></small>
                                            </label>
                                        </h4>
                                    </div>
                                    <p>&nbsp;&nbsp;&nbsp;&nbsp;
                                        <#if permission.children?? && permission.children?size gt 0>
                                            <#list permission.children as child>
                                                <label class="checkbox-inline">
                                                    <input name="permission.id" id="perm${child.id}" type="checkbox"
                                                           value="${child.id}"> ${(child.name)!}
                                                    (${child.value})
                                                    <small class="operate">
                                                        <a class="update" permid="${child.id}"
                                                           permname="${child.name}"
                                                           permintro="${child.intro}"
                                                           permvalue="${child.value}" permurl="${child.url}"
                                                           data-toggle="modal" href="#perm_save">修改</a>&nbsp;<a
                                                            class="delete"
                                                            permid="${child.id}" data-toggle="modal"
                                                            href="#delete">删除</a>
                                                    </small>
                                                </label>
                                            </#list>
                                        </#if>
                                    </p>
                                </div>
                            </div>
                        </#list>
                        <button type="button" class="btn btn-primary hide save" data-loading-text="正在保存..."
                                data-complete-text="保存成功!">保存
                        </button>
                    </#if>
                </form>
            </div>
        </div>
    </div>
</div>
</@layout>
<!-- Modal -->
<div class="modal fade" id="role_save" tabindex="-1" role="dialog" aria-labelledby="role_saveLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="role_saveLabel">角色</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="/role/save">
                    <input type="hidden" name="operate" value="save">
                    <input type="hidden" name="role.id" value="">
                    <input type="hidden" name="role.pid" value="">

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="role_name">名称:</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" maxlength="20" id="role_name" name="role.name"
                                   value="${(role.name)!}" placeholder="名称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="value">标识:</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" maxlength="20" id="value" name="role.value"
                                   value="${(role.value)!}" placeholder="标识">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="role_des">描述:</label>

                        <div class="col-sm-10">
                            <textarea class="form-control" maxlength="240" rows="3" id="role_des"
                                      name="role.intro"
                                      value="${(role.intro)!}" placeholder="描述"></textarea>
                        </div>
                    </div>
                    <div class="error-box"></div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary save" data-loading-text="正在保存..."
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
<div class="modal fade" id="perm_save" tabindex="-1" role="dialog" aria-labelledby="perm_saveLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="perm_saveLabel">权限</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="/perm/save">
                    <input type="hidden" name="operate" value="save">
                    <input type="hidden" name="permission.id" value="">
                    <input type="hidden" name="permission.pid" value="">

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="permission_name">名称:</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" maxlength="20" id="permission_name"
                                   name="permission.name"
                                   value="${(permission.name)!}" placeholder="名称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="value">标识:</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" maxlength="20" id="value"
                                   name="permission.value"
                                   value="${(permission.value)!}" placeholder="标识">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="perm_url">URL:</label>

                        <div class="col-sm-10">
                            <input type="text" class="form-control" maxlength="20" id="perm_url"
                                   name="permission.url"
                                   value="${(permission.url)!}" placeholder="URL">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="permission_des">描述:</label>

                        <div class="col-sm-10">
                            <textarea class="form-control" maxlength="240" rows="3" id="permission_des"
                                      name="permission.intro"
                                      value="${(permission.intro)!}" placeholder="描述"></textarea>
                        </div>
                    </div>
                    <div class="error-box"></div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary save" data-loading-text="正在保存..."
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
<div class="modal fade" id="delete" tabindex="-1" role="dialog" aria-labelledby="deleteLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="deleteLabel">删除</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="/role/delete">
                    <input type="hidden" name="for" value="role">
                    <input type="hidden" name="role.id" value="">
                    <input type="hidden" name="permission.id" value="">
                    <span name="text"></span>

                    <div class="error-box"></div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary delete" data-loading-text="正在删除..."
                        data-complete-text="删除成功!">确定
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
    require(['_treenav','_valid','_pagination'], function () {
        $(function () {
        <#if role??>
            //初始化
            ckeckPermission(${role.id});
        </#if>

            function ckeckPermission(roleId) {
                if (roleId > 0) {
                    var currentRoleId = $("input[name='current_role_id']").val();
                    var permsChk = $("#role_perms").find("input[type='checkbox'][id^='perm']");
                    permsChk.prop("checked", false);
                    $.post("/admin/permIds", {"role.id": roleId}, function (data) {
                        if (data.permIds) {
                            $.each(data.permIds, function (index, element) {
                                $("#role_perms").find("input[type='checkbox'][id='perm" + element + "']").prop("checked", true);
                            });
                            if (roleId == currentRoleId) {
                                permsChk.prop("disabled", true);
                                permsChk.addClass("disabled");
                            }
                        }
                    }, "json");
                }
            }

            //点击树形菜单
            $(".treenav a").click(function () {
                var roleId = $(this).attr("nodeid");
                //初始化权限
                ckeckPermission(roleId);
                //权限表单
                $("#role_perms").find("input[name='role.id']").val(roleId);
                var permsBtn = $("#role_perms").find("button.save");
                var permsChk = $("#role_perms").find("input[type='checkbox'][id^='perm']");

                $("div[name='node_name']").text($(this).attr("name"));
                $("div[name='node_key']").text($(this).attr("value"));
                $("div[name='node_intro']").text($(this).attr("intro"));
                var delete_at = $(this).attr("delete_at");
                $("input[name='node_delete_at']").val(delete_at);
                $("div[name='node_delete_at']").text((delete_at ? '已删除' : '正常'));
                $("input[name='node_id']").val(roleId);
                var currentRoleId = $("input[name='current_role_id']").val();
                var dela = $("div[name='node_operation']").find("a.delete");


                if (roleId == currentRoleId) {
                    dela.addClass("hide");
                    permsBtn.addClass("hide");
                    permsChk.prop("disabled", true);
                    permsChk.addClass("disabled");
                } else {
                    dela.removeClass("hide");
                    permsBtn.removeClass("hide");
                    permsChk.prop("disabled", false);
                    permsChk.removeClass("disabled");
                }
            });

            //角色操作
            $("div[name='node_operation'] a").click(function () {
                var a = $(this);
                if (a.hasClass("save")) {
                    var form = $("#role_save.modal").find("form");
                    form[0].reset();
                    form.find("input[name='operate']").val("save");
                    form.find("input[name='role.id']").val("");
                    var rolepid = form.find("input[name='role.pid']");
                    rolepid.val($("input[name='node_id']").val());
                } else if (a.hasClass("update")) {
                    var form = $("#role_save.modal").find("form");
                    form.find("input[name='operate']").val("update");
                    var roleid = form.find("input[name='role.id']");
                    roleid.val($("input[name='node_id']").val());
                    //清空pid
                    form.find("input[name='role.pid']").val("");

                    var rolename = form.find("input[name='role.name']");
                    rolename.val($("div[name='node_name']").text());

                    var rolekey = form.find("input[name='role.value']");
                    rolekey.val($("div[name='node_key']").text());

                    var roleintro = form.find("textarea[name='role.intro']");
                    roleintro.val($("div[name='node_intro']").text());
                } else if (a.hasClass("delete")) {
                    var form = $("#delete.modal").find("form");
                    form.find("input[name='for']").val("role");
                    form.find("span[name='text']").text("确定删除该角色?");
                    var roleid = form.find("input[name='role.id']");
                    roleid.val($("input[name='node_id']").val());
                    form.find("div.error-box").html("");
                }
            });

            //添加,更新事件
            $("#role_save button.save").click(function () {
                var btn = $(this);
                var form = $("#role_save.modal").find("form");
                var operate = form.find("input[name='operate']").val();
                var valid = $.valid('#role_save.modal',
                        {
                            wrapper: "div.form-group",
                            rules: {
                                "role.name": [
                                    {regex: /^[\u2E80-\u9FFF\w]{2,10}$/}
                                ],
                                "role.value": [
                                    {regex: /^\w{2,20}$/}
                                ],
                                "role.intro": [
                                    {regex: /^[\s\S]{3,240}$/}
                                ]
                            },
                            messages: {
                                "role.name": {'regex': '名称为中文、英文字母、数字和下划线长度为2-10'},
                                "role.value": {'regex': '标识为英文字母、数字和下划线长度为2-20'},
                                "role.intro": {'regex': '描述长度为3-240个字符'}
                            }, boxer: {exist: true}});
                //验证成功
                if (valid.validate()) {
                    btn.button('loading');

                    //添加
                    if (operate == "save") {
                        $.post("/admin/roleSave", form.serialize(), function (data) {
                            if (data.state == "success") {
                                btn.button('complete');
                                setTimeout(function () {
                                    btn.button('reset');
                                    window.location.reload();
                                }, 1000)
                            } else {
                                var errors = "";
                                errors = checkError(errors, data.role_pidMsg);
                                errors = checkError(errors, data.role_nameMsg);
                                errors = checkError(errors, data.role_valueMsg);
                                errors = checkError(errors, data.role_introMsg);
                                form.find("div.error-box").html(errors);
                                btn.button('reset');
                            }
                        }, "json");
                    }//更新
                    else {
                        $.post("/admin/roleUpdate", form.serialize(), function (data) {
                            if (data.state == "success") {
                                btn.button('complete');
                                setTimeout(function () {
                                    btn.button('reset');
                                    window.location.reload();
                                }, 1000)
                            } else {
                                var errors = "";
                                errors = checkError(errors, data.role_idMsg);
                                errors = checkError(errors, data.role_nameMsg);
                                errors = checkError(errors, data.role_valueMsg);
                                errors = checkError(errors, data.role_introMsg);
                                form.find("div.error-box").html(errors);
                                btn.button('reset');
                            }
                        }, "json");
                    }
                }
            });
            //权限操作
            $("small.operate a").click(function () {
                var a = $(this);
                if (a.hasClass("save")) {
                    var form = $("#perm_save.modal").find("form");
                    form[0].reset();
                    form.find("input[name='permission.id']").val("");
                    form.find("input[name='operate']").val("save");
                    form.find("input[name='permission.pid']").val(a.attr("permid"));
                } else if (a.hasClass("update")) {
                    var form = $("#perm_save.modal").find("form");
                    form.find("input[name='operate']").val("update");

                    form.find("input[name='permission.id']").val(a.attr("permid"));
                    form.find("input[name='permission.pid']").val("");
                    form.find("input[name='permission.name']").val(a.attr("permname"));
                    form.find("input[name='permission.value']").val(a.attr("permvalue"));
                    form.find("textarea[name='permission.intro']").val(a.attr("permintro"));
                    form.find("input[name='permission.url']").val(a.attr("permurl"));

                } else if (a.hasClass("delete")) {
                    var form = $("#delete.modal").find("form");
                    form.find("input[name='for']").val("permission");
                    form.find("span[name='text']").text("确定删除该权限?");
                    var permid = form.find("input[name='permission.id']");
                    permid.val(a.attr("permid"));
                }
            });
            //添加,更新事件
            $("#perm_save button.save").click(function () {
                var btn = $(this);
                var form = $("#perm_save.modal").find("form");
                var operate = form.find("input[name='operate']").val();
                var valid = $.valid('#perm_save.modal',
                        {
                            wrapper: "div.form-group",
                            rules: {
                                "permission.name": [
                                    {regex: /^[\u2E80-\u9FFF\w]{2,10}$/}
                                ],
                                "permission.value": [
                                    {regex: /^\w{2,20}$/}
                                ],
                                "permission.url": [
                                    {regex: /^[\w\/\*]+$/}
                                ],
                                "permission.intro": [
                                    {regex: /^[\s\S]{3,240}$/}
                                ]
                            },
                            messages: {
                                "permission.name": {'regex': '名称为中文、英文字母、数字和下划线长度为2-10'},
                                "permission.value": {'regex': '标识为英文字母、数字和下划线长度为2-20'},
                                "permission.url": {'regex': 'url为英文字母、数字、*、下划线和右斜线'},
                                "permission.intro": {'regex': '描述长度为3-240个字符'}
                            }, boxer: {exist: true}});
                //验证成功
                if (valid.validate()) {
                    btn.button('loading');

                    //添加
                    if (operate == "save") {
                        $.post("/admin/permSave", form.serialize(), function (data) {
                            if (data.state == "success") {
                                btn.button('complete');
                                setTimeout(function () {
                                    btn.button('reset');
                                    window.location.reload();
                                }, 1000)
                            } else {
                                var errors = "";
                                errors = checkError(errors, data.permission_pidMsg);
                                errors = checkError(errors, data.permission_nameMsg);
                                errors = checkError(errors, data.permission_valueMsg);
                                errors = checkError(errors, data.permission_urlMsg);
                                errors = checkError(errors, data.permission_introMsg);
                                form.find("div.error-box").html(errors);
                                btn.button('reset');
                            }
                        }, "json");
                    }//更新
                    else {
                        $.post("/admin/permUpdate", form.serialize(), function (data) {
                            if (data.state == "success") {
                                btn.button('complete');
                                setTimeout(function () {
                                    btn.button('reset');
                                    window.location.reload();
                                }, 1000)
                            } else {
                                var errors = "";
                                errors = checkError(errors, data.permission_pidMsg);
                                errors = checkError(errors, data.permission_nameMsg);
                                errors = checkError(errors, data.permission_valueMsg);
                                errors = checkError(errors, data.permission_urlMsg);
                                errors = checkError(errors, data.permission_introMsg);
                                form.find("div.error-box").html(errors);
                                btn.button('reset');
                            }
                        }, "json");
                    }
                }
            });
            //删除事件
            $("#delete button.delete").click(function () {
                var btn = $(this);
                var form = $("#delete.modal").find("form");
                var forInp = form.find("input[name='for']").val();
                if (forInp == "role") {
                    $.post("/admin/roleDrop", form.serialize(), function (data) {
                        if (data.state == "success") {
                            btn.button('complete');
                            setTimeout(function () {
                                btn.button('reset');
                                window.location.reload();
                            }, 1000)
                        } else {
                            var errors = "";
                            errors = checkError(errors, data.role_idMsg);
                            form.find("div.error-box").html(errors);
                            btn.button('reset');
                        }
                    }, "json");
                } else {
                    $.post("/admin/permDrop", form.serialize(), function (data) {
                        if (data.state == "success") {
                            btn.button('complete');
                            setTimeout(function () {
                                btn.button('reset');
                                window.location.reload();
                            }, 1000)
                        } else {
                            var errors = "";
                            errors = checkError(errors, data.permission_idMsg);
                            form.find("div.error-box").html(errors);
                            btn.button('reset');
                        }
                    }, "json");
                }
            });

            //修改权限
            $("#role_perms").find("button.save").click(function () {
                var btn = $(this);
                var form = $("#role_perms");
                $.post("/admin/permsAdd", form.serialize(), function (data) {
                    if (data.state == "success") {
                        btn.button('complete');
                        setTimeout(function () {
                            btn.button('reset');
                        }, 1000)
                    } else {
                        var errors = "";
                        errors = checkError(errors, data.role_idMsg);
                        form.find("div.error-box").html(errors);
                        btn.button('reset');
                    }
                }, "json");
            });
        });
    });
});
</script>