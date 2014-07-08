$(function () {
    $(".treenav li").click(function () {
        var li = $(this);
        if (!li.parent().parent().is(".treenav")) {
            $(".treenav li").removeClass("active");
            li.parents(".treenav li").addClass("active");
            li.addClass("active");
            li.siblings().removeClass("active");
            li.siblings().children("li.active").removeClass("active");
            var icon = li.find("i:first");
            var children = li.children("ul.nav");
            if (children.length > 0) {
                icon.toggleClass("glyphicon-minus-sign");
                icon.toggleClass("glyphicon-plus-sign");
            }
            children.toggleClass("hide");
        }

        if (event && event.stopPropagation) {
            //W3C取消冒泡事件
            event.stopPropagation();
        } else {
            //IE取消冒泡事件
            window.event.cancelBubble = true;
        }   //  阻止事件冒泡
    });
})
