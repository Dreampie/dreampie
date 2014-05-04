(function ($, window, document) {

  // Main function
  $.fn.areaTag = function (_areas, options) {
    $.fn.areaTag.init(_areas, options, this);
  };
// Init
  $.fn.areaTag.init = function (_areas, options) {
    //填充数据
    fillChildren = function (pid, level, _areas) {
      if (_areas && _areas.length > 0) {
        $.each(_areas, function (index, element) {
          if (pid == element.pid) {
            var p = $("<li></li>");
            var t = $("<a href='#' value=" + element.id + " >" + element.name + "</a>");
            t.click(function () {
              //显示当前选择
              var span = $(this).parents(".btn-group").find('span.selection');
              span.text($(this).text().substr(0, 3));
              span.attr("title", $(this).text());
              $(this).parents(".btn-group").find('input.selection').val($(this).attr("value"));
              $("ul." + s.name[level]).prepend(p);
              //原数据重置
              var ul;
              for (var i = level + 1; i < s.name.length; i++) {
                ul = $("ul." + s.name[i]);
                //重置名称
                ul.parents(".btn-group").find('span.selection').text(s.freeTxt[i])
                //删除原节点
                var lis = ul.find("li");
                lis.each(function () {
                  lis = ul.find("li");
                  if (lis.length > 2) {
                    if ($(this).index() < lis.length - 2)
                      $(this).remove();
                  }
                });
              }
              //填充新子集
              fillChildren(element.id, level + 1, _areas)
            });
            p.html(t);
            $("ul." + s.name[level]).prepend(p);
          }
        });
      }
    };

    fillBack = function (checked, _areas) {
      if (checked.length > 0) {
        if (_areas && _areas.length > 0) {
          $.each(checked, function (cindex, celement) {
            if (!isNaN(celement)) {
              $.each(_areas, function (index, element) {
                if (celement == element.id) {
                  var btn = $("ul." + s.name[cindex]).parents(".btn-group");
                  //回显填充数据
                  $(btn.find('span.selection')).text(element.name.substr(0, 3));
                  $(btn.find('span.selection')).attr("title", element.name);
                  $(btn.find('input.selection')).val(element.id);
                  fillChildren(element.id, cindex + 1, _areas)
                }
              });
            }
          });
        }
      }
    };
    // Apply any options to the settings, override the defaults
    var s = $.fn.areaTag.settings = $.extend({}, $.fn.areaTag.defaults, options),
        areaFillback = fillBack(s.checked, _areas),
        areaFill = fillChildren(0, 0, _areas);

  };

  // Defaults
  $.fn.areaTag.defaults = {
    name: ['province', 'city', 'county'],
    checked: [],
    freeTxt: ['省份', '市区', '城镇']//prepend,append
  };

  $.areaTag = $.fn.areaTag;
})(jQuery, window, document);
