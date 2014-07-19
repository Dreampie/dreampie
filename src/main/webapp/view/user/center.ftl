<#include "/view/layout/_layout.ftl"/>
<@layout activebar="center" html_title="个人中心">
<!-- 面包屑 -->
<ol class="breadcrumb panel">
    <li><i class="fa fa-home"></i>&nbsp;<a title="Go to Home." href="/">Dreampie</a></li>
    <li><a title="Go to User." href="/user">User</a></li>
    <li class="active">Center</li>
</ol>
<!-- 面包屑 -->
<div class="row">
    <div class="col-md-6">
        <#if user??>
            <form id="update_pwd" class="form-horizontal" role="form" method="post" action="/user/updatePwd">
                <div class="form-group">
                    <label for="username" class="col-sm-2 control-label">用 户 名:</label>
                    <input type="hidden" name="user.id" value="${user.id}">
                    <input type="hidden" name="user.username" value="${user.username}">

                    <div class="col-sm-10">
                    ${(user.full_name)!}(${(user.username)!})
                    </div>
                </div>
                <div class="form-group">
                    <label for="oldPassword" class="col-sm-2 control-label">原 密 码:</label>

                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="oldPassword" name="oldpassword"
                               placeholder="Oldpassword">
                    </div>
                </div>
                <div class="form-group">
                    <label for="password" class="col-sm-2 control-label">新 密 码:</label>

                    <div class="col-sm-10">
                        <input type="password" name="user.password" class="form-control" id="password"
                               placeholder="Password">
                    </div>
                </div>
                <div class="form-group">
                    <label for="repassword" class="col-sm-2 control-label">重复密码:</label>

                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="repassword" name="repassword"
                               placeholder="Repassword">
                    </div>
                </div>
                <#if state?? && state=="success">
                    <span style="color: green">修改成功</span>
                <#elseif state?? && state=="failure">
                    <span style="color: red">修改失败</span>
                </#if>
                <div class="error-box"></div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="reset" class="btn btn-default">重置</button>
                        <button type="button" class="btn btn-primary save" data-loading-text="正在保存..."
                                data-complete-text="保存成功!">保存
                        </button>
                    </div>
                </div>
            </form>
        </#if>
    </div>
</div>
</@layout>

<script type="text/javascript">
    require(['../../javascript/app'], function () {
        require(['_valid'], function () {
            $(function () {
                $("#update_pwd button.save").click(function () {

                    var btn = $(this);
                    var form = $("#update_pwd");
                    //表单验证
                    var uservalid = $.valid('#update_pwd', {
                        wrapper: "div.form-group",
                        rules: {
                            "oldpassword": [
                                'not_empty', {regex: /^(\w{5,18})?$/}
                            ],
                            "user.password": [
                                'not_empty', {regex: /^(\w{5,18})?$/}
                            ],
                            "repassword": [
                                {matches: 'user.password'}
                            ]},
                        messages: {
                            "oldpassword": {not_empty: '原始密码不能为空', 'regex': '密码为英文字母 、数字和下划线长度为5-18'},
                            "user.password": {not_empty: '密码不能为空', 'regex': '密码为英文字母 、数字和下划线长度为5-18'},
                            "repassword": {'matches': '重复密码不一致'}
                        }, boxer: {exist: true}});

                    if (uservalid.validate()) {
                        $.post("/user/updatePwd", form.serialize(), function (data) {
                            if (data.state == "success") {
                                btn.button('complete');
                                setTimeout(function () {
                                    btn.button('reset');
                                    window.location.reload();
                                }, 1000)
                            } else {
                                var errors = "";
                                errors = checkError(errors, data.user_idMsg);
                                errors = checkError(errors, data.user_usernameMsg);
                                errors = checkError(errors, data.user_oldpasswordMsg);
                                errors = checkError(errors, data.user_passwordMsg);
                                errors = checkError(errors, data.repasswordMsg);
                                form.find("div.error-box").html(errors);
                                btn.button('reset');
                            }
                        }, "json");
                    }
                });
            });
        });
    });
</script>