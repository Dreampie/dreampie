//require(['app'], function () {
//the jquery.js
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
    if ($("form input[type!='button'][type!='submit']").length > 0) {
        $("form input[type!='button'][type!='submit']").maxlength({
            alwaysShow: true
        });
    }
    if ($("form textarea").length > 0) {
        $("form textarea").maxlength({
            alwaysShow: true
        });
    }
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

    //输入金额
    if ($('input.checkMoney').length > 0) {
        $("input.checkMoney").each(function () {
            onlyMoney($(this));
        });
    }

    //输入数字
    if ($('input.checkNum').length > 0) {
        $("input.checkNum").each(function () {
            onlyNum($(this));
        });
    }
});
//});


// ajax  error
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
    /* var re = /(-?\d+)(\d{3})/;
     while(re.test(number))
     number = number.replace(re,"$1,$2");*/
    return number;
}

/**
 * 限制文本框只能输入数字
 * @param event
 * @returns {Boolean}
 */
function onlyNum(obj) {
    var numval = /^\d+$/;
    obj.keyup(function () {
        var _value = $(this).val();
        if (!(numval.test(_value) && _value > 0)) {
            var v = Number(_value.replace(/[^0-9]/g, ''));
            if (v > 0)
                $(this).val(v);
            else
                $(this).val("");
        } else {
            $(this).val(Number(_value));
        }
    }).bind("paste", function () {  //CTR+V事件处理
        var _value = $(this).val();
        if (!(numval.test(_value) && _value > 0)) {
            var v = Number(_value.replace(/[^0-9]/g, ''));
            if (v > 0)
                $(this).val(v);
            else
                $(this).val("");
        } else {
            $(this).val(Number(_value));
        }
    }).focus(function () {
            this.style.imeMode = 'disabled';
        }
    );
}

/**
 * 限制文本框只能输入金额
 * @param event
 * @returns {Boolean}
 */
function onlyMoney(obj) {
    var numma = /-?\d+\.?\d{0,2}/;
    var numval = /^-?\d+\.?\d{0,2}$/;
    obj.keyup(function () {
        var _value = $(this).val();
        if (_value.length >= 2 && !numval.test(_value)) {
            var ma = _value.match(numma);
            if (ma && ma.length >= 2)
                $(this).val(ma[0]);
            else {
                if (_value.indexOf("-") == 0)
                    $(this).val("-");
                else
                    $(this).val("");
            }
        } else {
            $(this).val(_value.replace(/[^0-9.-]/g, ''));
        }
    }).bind("paste", function () {  //CTR+V事件处理
        var _value = $(this).val();
        if (_value.length >= 2 && !numval.test(_value)) {
            var ma = _value.match(numma);
            if (ma && ma.length >= 2)
                $(this).val(ma[0]);
            else {
                if (_value.indexOf("-") == 0)
                    $(this).val("-");
                else
                    $(this).val("");
            }
        } else {
            $(this).val(_value.replace(/[^0-9.-]/g, ''));
        }
    }).focus(function () {
            this.style.imeMode = 'disabled';
        }
    ); //CSS设置输入法不可用
}


function randomNum(digit) {
    if (digit <= 1) {
        return  Math.floor(Math.random() * 10);
    }
    var bitField = 0;
    var chars = "";
    for (var i = 0; i < digit; i++) {
        while (true) {
            var k = Math.floor(Math.random() * 10);
            if ((bitField & (1 << k)) == 0) {
                bitField |= 1 << k;
                chars += k;
                break;
            }
        }
    }
    return chars;
}