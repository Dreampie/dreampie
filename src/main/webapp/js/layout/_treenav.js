$(function () {
  $(".treenav li").click(function () {
    var li = $(this);
    li.addClass("active");
    li.siblings("li").removeClass("active");
    li.parents("li.active").each(function () {
      var li_p = $(this);
      li_p.siblings().removeClass("active");
      li_p.siblings().each(function () {
        var li_sib = $(this);
        li_sib.children("li.active").removeClass("active");
      })
    });
    li.children("ul.nav").hide();
    li.children("ul.nav:first").show();
    li.siblings("li").children("ul.nav").hide();
  });
})
