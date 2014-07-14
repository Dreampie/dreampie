<!-- Modal -->
<div class="modal fade" id="upd_intro" tabindex="-1" role="dialog" aria-labelledby="upd_introModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="upd_introModalLabel">备注</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="/user/updateIntro">
                    <input type="hidden" name="follower.id" value="">

                    <div class="form-group">
                        <label class="col-sm-3 textright">账户:</label>

                        <div class="col-sm-9" name="username"></div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">备注:</label>

                        <div class="col-sm-9" name="role">
                            <textarea name="follower.intro" class="form-control" rows="3" placeholder="备注"></textarea>
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
    require(['../../javascript/app'], function () {
        require(['_valid'], function () {
            $(function () {
                //修改备注
                var upd_introbtn = $("#upd_intro.modal button.upd_intro");
                upd_introbtn.click(function () {
                    var btn = $(this);
                    var form = $("#upd_intro.modal form");
                    //表单验证
                    var upd_introvalid = $.valid('#upd_intro.modal form', {
                        wrapper: "div.form-group",
                        rules: {
                            "follower.id": [
                                {regex: /^\d+$/}
                            ], "follower.intro": [
                                {regex: /^[\s\S]{3,240}$/}
                            ]},
                        messages: {
                            "follower.id": {'regex': '联系人参数异常'},
                            "follower.intro": {'regex': '备注长度为3-240个字符'}
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
            });
        });
    });
</script>