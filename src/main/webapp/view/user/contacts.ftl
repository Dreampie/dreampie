<#include "/view/layout/_layout.ftl"/>
<#include "/view/layout/_pagination.ftl" />
<@layout activebar="contacts" html_title=i18n.getText("user.contacts")>
<script type="text/javascript" src="<@resource.static/>/javascript/layout/jquery.form.js"></script>
<script type="text/javascript" src="<@resource.static/>/javascript/layout/_valid.js"></script>

<div class="row">
    <div class="col-md-4 searchline">
        <form id="user_search" class="searchbar " role="form" action="/user/contacts" method="get" data-view="searchbar" data-classname="col-sm-4"
              data-inputclass="form-control" data-placeholder="姓名，电话，地址等">
            <span style=" position: relative; ">
                <input class="tt-hint" type="text" autocomplete="off" spellcheck="off" disabled=""
                       style="position: absolute; top: 0px; left: 0px; border-color: transparent; box-shadow: none; background-attachment: scroll; background-clip: border-box; background-color: rgb(255, 255, 255); background-image: none; background-origin: padding-box; background-size: auto; background-position: 0% 0%; background-repeat: repeat repeat;">
                <input name="user_search" type="text" value="${(user_search)!}" placeholder="姓名，电话，地址等" class="form-control tt-query"
                       required="" autocomplete="off"
                       spellcheck="false" maxlength="20"
                       dir="auto" style="/* position: relative; */vertical-align: top;background-color: transparent;">
                <span class="tt-dropdown-menu" style="position: absolute; top: 100%; left: 0px; z-index: 100; display: none;"></span>
            </span>
            <button type="submit" class="glyphicon glyphicon-search search"></button>
        <#--<div class="error-box">${user_searchMsg!}</div>-->
        </form>

    <#--<form id="user_search" class="form-inline" role="form" action="/user/contacts" method="get">-->
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
                                    <#assign avatar_url='/image/avatar.jpg'/>
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
                                        ${(user.province)!}&nbsp;${(user.city)!}&nbsp;${(user.county)!}&nbsp;${(user.street)!}
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
                                <button type="button" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#del_user"
                                        contactsid="${user.id}" username="${username}">删除
                                </button>
                                <button type="button" class="btn btn-default btn-xs" data-toggle="modal" data-target="#upd_intro"
                                        contactsid="${user.id}" username="${username}" intro="${user.intro}">备注
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
        <@paginate currentPage=users.pageNumber totalPage=users.totalPage actionUrl=localUri urlParas=localParas className="pagination"/>
    </#if>
    </div>
</div>
</@layout>

<!-- Modal -->
<div class="modal fade" id="del_user" tabindex="-1" role="dialog" aria-labelledby="del_userModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="del_userModalLabel">删除</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="/user/deleteContacts">
                    <input type="hidden" name="contacts.id" value="">

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
<div class="modal fade" id="upd_intro" tabindex="-1" role="dialog" aria-labelledby="upd_introModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="upd_introModalLabel">修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="/user/updateIntro">
                    <input type="hidden" name="contacts.id" value="">

                    <div class="form-group">
                        <label class="col-sm-3 textright">账户:</label>

                        <div class="col-sm-9" name="username"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">备注:</label>

                        <div class="col-sm-9" name="role">
                            <textarea name="contacts.intro" class="form-control" rows="3" placeholder="备注"></textarea>
                        </div>
                    </div>
                    <div class="error-box"></div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary upd_intro" data-loading-text="正在保存..."
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
            var del_user = "#del_user";
            var upd_intro = "#upd_intro";
            //装配数据
            $("div.modal div[name='username']").text(opbtn.attr("username"));
            if (opbtn.attr("data-target") == del_user) {
                $(del_user + " input[name='contacts.id']").val(opbtn.attr("contactsid"));
            } else if (opbtn.attr("data-target") == upd_intro) {
                $(upd_intro + " input[name='contacts.id']").val(opbtn.attr("contactsid"));
                $(upd_intro + " textarea[name='contacts.intro']").val(opbtn.attr("intro"));
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
                    "contacts.id": [
                        {regex: /^\d+$/}
                    ]},
                messages: {
                    "contacts.id": {'regex': '联系人参数异常'}
                }, boxer: {exist: true}});

            if (del_uservalid.validate()) {
                btn.button('loading');
                $.post("/user/deleteContacts", form.serialize(), function (data) {
                    if (data.state == "success") {
                        btn.button('complete');
                        setTimeout(function () {
                            btn.button('reset');
                            window.location.reload();
                        }, 1000)
                    } else {
                        var errors = "";
                        errors = checkError(errors, data.idMsg);
                        form.find("div.error-box").html(errors);
                        btn.button('reset');
                    }
                }, "json").error(function () {
                    btn.button('reset');
                });
            }
        });

        //修改备注
        var upd_introbtn = $("#upd_intro.modal button.upd_intro");
        upd_introbtn.click(function () {
            var btn = $(this);
            var form = $("#upd_intro.modal form");
            //表单验证
            var upd_introvalid = $.valid('#upd_intro.modal form', {
                wrapper: "div.form-group",
                rules: {
                    "contacts.id": [
                        {regex: /^\d+$/}
                    ], "contacts.intro": [
                        {regex: /^[\s\S]{3,240}$/}
                    ]},
                messages: {
                    "contacts.id": {'regex': '联系人参数异常'},
                    "contacts.intro": {'regex': '备注长度为3-240个字符'}
                }, boxer: {exist: true}});

            if (upd_introvalid.validate()) {
                btn.button('loading');
                $.post("/user/updateIntro", form.serialize(), function (data) {
                    if (data.state == "success") {
                        btn.button('complete');
                        setTimeout(function () {
                            btn.button('reset');
                            window.location.reload();
                        }, 1000)
                    } else {
                        var errors = "";
                        errors = checkError(errors, data.idMsg);
                        errors = checkError(errors, data.introMsg);
                        form.find("div.error-box").html(errors);
                        btn.button('reset');
                    }
                }, "json").error(function () {
                    btn.button('reset');
                });
            }
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