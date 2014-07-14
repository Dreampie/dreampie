<!-- Modal -->
<div class="modal fade" id="del_following" tabindex="-1" role="dialog" aria-labelledby="del_followingModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="del_followingModalLabel">取消关注</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="/user/deletefollower">
                    <input type="hidden" name="follower.id" value="">

                    <div class="form-group">
                        <label class="col-sm-3 textright">账户:</label>

                        <div class="col-sm-9" name="username"></div>
                    </div>
                    <div class="error-box"></div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary del_following" data-loading-text="正在取消..."
                        data-complete-text="取消成功!">取消
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

                //删除用户
                var del_followingbtn = $("#del_following.modal button.del_following");
                del_followingbtn.click(function () {
                    var btn = $(this);
                    var form = $("#del_following.modal form");
                    //表单验证
                    var del_followingvalid = $.valid('#del_following.modal form', {
                        wrapper: "div.form-group",
                        rules: {
                            "follower.id": [
                                {regex: /^\d+$/}
                            ]},
                        messages: {
                            "follower.id": {'regex': '联系人参数异常'}
                        }, boxer: {exist: true}});

                    if (del_followingvalid.validate()) {
                        btn.button('loading');
                        $.post("/user/deleteFollowing", form.serialize(), function (data) {
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