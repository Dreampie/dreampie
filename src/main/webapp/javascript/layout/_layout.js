$(function () {
    //下拉菜单回显数据
    $(".dropdown-menu li.checked").each(function () {
        $(this).parents(".btn-group").find('span.selection').text($(this).text());
        $(this).parents(".btn-group").find('input.selection').val($(this).find("a").attr("value"));
    });

    $(".dropdown-menu li a").click(function () {
        $(this).parents(".btn-group").find('span.selection').text($(this).text());
        $(this).parents(".btn-group").find('input.selection').val($(this).attr("value"));
    });
    //长度限制
    $("form input[type!='button'][type!='submit']").maxlength({
        alwaysShow: true
    });
    //时间控件
    if ($('.form_datetime').length > 0) {
        $('.form_datetime').datetimepicker({
            language: 'zh-CN',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            forceParse: 0,
            showMeridian: 1
        });
    }
    //验证码
    if ($("img.captcha").length > 0) {
        $("img.captcha").click(function () {
            var img = $(this);
            var query = $.query().load(img.attr("src"));
            img.attr("src", query.set("time", new Date().getTime()));
        });
    }
    if ($("input[name='captcha']").length > 0) {
        $("input[name='captcha']").focus(function () {
            var now = new Date().getTime();
            var img = $("img.captcha");
            var query = $.query().load(img.attr("src"));
            var before = Number(query.get("time"));
            before = before <= 0 ? now : before;
            if (now - before > 300000) {
                $("img.captcha").click();
            }
        });
    }
})

/**
 * 格式化金额
 * @param number
 * @param digit
 * @returns
 */
function formatNumber(number, digit) {
    if (isNaN(digit)) {
        return "";
    }
    ;
    if (isNaN(number)) {
        return "";
    }
    ;
    //参数说明：num 要格式化的数字 n 保留小数位
    number = String(Number(number).toFixed(digit));
    var re = /(-?\d+)(\d{3})/;
    /* while(re.test(number))
     number = number.replace(re,"$1,$2");*/
    return number;
}
/**
 * 限制文本框只能输入数字
 * @param event
 * @returns {Boolean}
 */
function onlyNum(obj) {
    obj.keydown(function (event) {
        var keyCode = event.which;
        if (keyCode == 46 || keyCode == 8 || keyCode == 37 || keyCode == 39 || (keyCode >= 48 && keyCode <= 57) || (keyCode >= 96 && keyCode <= 105)) {
            return true;
        }
        else {
            return false;
        }
    }).focus(function () {
            this.style.imeMode = 'disabled';
        }
    );
}