/**
 * Created by wangrenhui on 2014/6/27.
 */
;
(function ($, window, document, undefined) {
//定义Number的构造函数
    var Digital = function (number, digit) {
        this.number = number, this.digit = digit;
    }
//定义Number的方法
    Digital.prototype = {
        format: function () {
            return String(Number(this.number).toFixed(this.digit));
        }
    }
    //在插件中使用Number对象
    $.fn.number = function (number, digit) {
        //创建Number的实体
        var digital = new Digital(number, digit);
        //调用其方法
        return digital.format();
    }
})(jQuery, window, document);