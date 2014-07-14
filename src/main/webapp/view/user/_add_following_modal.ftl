<!-- Modal -->
<div class="modal fade" id="add_following" tabindex="-1" role="dialog" aria-labelledby="add_followingModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="add_followingModalLabel">添加关注</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="/user/addFollowing">
                    <input type="hidden" name="follower.link_id" value="">

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
                <button type="button" class="btn btn-primary add_following" data-loading-text="正在关注..."
                        data-complete-text="关注成功!">关注
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

                //关注用户
                var add_followingbtn = $("#add_following.modal button.add_following");
                add_followingbtn.click(function () {
                    var btn = $(this);
                    var form = $("#add_following.modal form");
                    //表单验证
                    var add_followingvalid = $.valid('#add_following.modal form', {
                        wrapper: "div.form-group",
                        rules: {
                            "follower.id": [
                                {regex: /^\d+$/}
                            ]},
                        messages: {
                            "follower.id": {'regex': '联系人参数异常'}
                        }, boxer: {exist: true}});

                    if (add_followingvalid.validate()) {
                        btn.button('loading');
                        $.post("/user/addFollowing", form.serialize(), function (data) {
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
            });
        });
    });
</script>