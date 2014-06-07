(function ($, window, document) {

    // Main function
    $.fn.scrollHide = function (options) {
        $.fn.scrollHide.init(options, this);
    };

    // Init
    $.fn.scrollHide.init = function (options, target) {
        // Apply any options to the settings, override the defaults
        var o = $.fn.scrollHide.settings = $.extend({}, $.fn.scrollHide.defaults, options),

        // Set scrollTitle
            scrollTitle = (o.scrollTitle) ? o.scrollTitle : o.scrollText,

        //show tooltip
        // Scroll function
            scrollEvent = $(window).scroll(function () {
                // If from top or bottom
                if (o.scrollFrom === 'top') {
                    scrollDis = o.scrollDistance;
                } else {
                    scrollDis = $(document).height() - $(window).height() - o.scrollDistance;
                }
                // Switch animation type
                switch (o.animation) {
                    case 'fade':
                        $(($(window).scrollTop() > scrollDis) ? target.fadeOut(o.animationOutSpeed) : target.fadeIn(o.animationInSpeed));
                        break;
                    case 'slide':
                        $(($(window).scrollTop() > scrollDis) ? target.slideUp(o.animationOutSpeed) : target.slideDown(o.animationInSpeed));
                        break;
                    default:
                        $(($(window).scrollTop() > scrollDis) ? target.hide(0) : target.show(0));
                }
            });

    };

    // Defaults
    $.fn.scrollHide.defaults = {
        scrollDistance: 50, // Distance from top/bottom before showing element (px)
        scrollFrom: 'top', // 'top' or 'bottom'
        scrollSpeed: 300, // Speed back to top (ms)
        animation: 'fade', // Fade, slide, none
        animationInSpeed: 200, // Animation in speed (ms)
        animationOutSpeed: 200, // Animation out speed (ms)
        scrollText: 'Scroll to top', // Text for element, can contain HTML
        scrollTitle: false  // Set a custom <a> title if required. Defaults to scrollText
    };

    // Destroy scrollHide plugin and clean all modifications to the DOM
    $.fn.scrollHide.destroy = function (scrollEvent) {
        // If 1.7 or above use the new .off()
        if ($.fn.jquery.split('.')[1] >= 7) {
            $(window).off('scroll', scrollEvent);

            // Else use the old .unbind()
        } else {
            $(window).unbind('scroll', scrollEvent);
        }
    };

    $.scrollHide = $.fn.scrollHide;

})(jQuery, window, document);