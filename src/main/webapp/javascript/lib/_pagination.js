//http://www.jqueryrain.com/?gG3nSRDW
/**
 * This jQuery plugin displays pagination links inside the selected elements.
 *
 * @author Gabriel Birke (birke *at* d-scribe *dot* de)
 * @version 1.2
 * @param {int} maxentries Number of entries to paginate
 * @param {Object} opts Several options (see README for documentation)
 * @return {Object} jQuery Object
 */
jQuery.fn.pagination = function (maxentries, opts) {
    opts = jQuery.extend({
        items_per_page: 10,
        num_display_entries: 10,//分隔符中间显分页数  不包含当前页  奇数向上取整
        current_page: 1,
        num_edge_entries: 0,//起始点和结束点  显示分页数
        link_to: "#",
        prev_text: "Prev",
        next_text: "Next",
        ellipse_text: "...",
        prev_show_always: true,
        next_show_always: true,
        callback: function () {
            return false;
        },
        call_in_first: false
    }, opts || {});

    return this.each(function () {
        /**
         * Calculate the maximum number of pages
         */
        function numPages() {
            return Math.ceil(maxentries / opts.items_per_page);
        }

        /**
         * Calculate start and end point of pagination links depending on
         * current_page and num_display_entries.
         * @return {Array}
         */
        function getInterval() {
            var ne_half = Math.ceil(opts.num_display_entries / 2);
            var np = numPages() + 1;
            var upper_limit = np - opts.num_display_entries;
            var start = current_page > ne_half ? Math.max(Math.min((current_page - ne_half) < (np - opts.num_edge_entries) ? (current_page - ne_half) : (np - opts.num_edge_entries), upper_limit), 1) : 1;
            var end = current_page > ne_half ? Math.min((current_page + 1 + ne_half) > (1 + opts.num_edge_entries) ? (current_page + 1 + ne_half) : (1 + opts.num_edge_entries), np) : Math.min(1 + opts.num_edge_entries, np);
            return [start, end];
        }

        /**
         * This is the event handling function for the pagination links.
         * @param {int} page_id The new page number
         */
        function pageSelected(page_id, evt) {
            current_page = page_id;
            drawLinks();
            var continuePropagation = opts.callback(page_id, panel);
            if (!continuePropagation) {
                if (evt.stopPropagation) {
                    evt.stopPropagation();
                }
                else {
                    evt.cancelBubble = true;
                }
            }
            return continuePropagation;
        }

        /**
         * This function inserts the pagination links into the container element
         */
        function drawLinks() {
            panel.empty();
            var interval = getInterval();
            var np = numPages() + 1;
            // This helper function returns a handler function that calls pageSelected with the right page_id
            var getClickHandler = function (page_id) {
                return function (evt) {
                    return pageSelected(page_id, evt);
                }
            }
            // Helper function for generating a single link (or a span tag if it's the current page)
            var appendItem = function (page_id, appendopts) {
                page_id = page_id < 1 ? 1 : (page_id < np ? page_id : np); // Normalize page id to sane value
                appendopts = jQuery.extend({text: page_id, classes: ""}, appendopts || {});

                var lir = jQuery("<li></li>");
                if (page_id == current_page) {
                    lir.addClass('active');
//          var lnk = jQuery("<span class='current'>"+(appendopts.text)+"</span>");
                    var lnk = jQuery("<a href='javascript:void(0);'>" + (appendopts.text) + "<span class='sr-only'>(current)</span></a>");
                }
                else {
//          var lnk = jQuery("<a>"+(appendopts.text)+"</a>")
                    var lnk = jQuery("<a>" + (appendopts.text) + "</a>")
                        .bind("click", getClickHandler(page_id))
                        .attr('href', opts.link_to.replace(/__id__/, page_id));

                }
                if (appendopts.classes) {
                    lnk.addClass(appendopts.classes);
                }
                lir.append(lnk);
                panel.append(lir);
            }
            // Generate a range of numeric links
            var appendRange = function (start, end, appendopts) {
                for (var i = start; i < end; i++) {
                    appendItem(i, appendopts);
                }
            }
            // Generate "Previous"-Link
            if (opts.prev_text && (current_page >= 1 || opts.prev_show_always)) {
//				appendItem(current_page-1,{text:opts.prev_text, classes:"prev"});
                if (current_page == 1) {
                    jQuery("<li class='disabled'><span class='prev_page'>" + opts.prev_text + "</span></li>").appendTo(panel);
                } else {
                    appendItem(current_page - 1, {text: opts.prev_text});
                }
            }
            // Generate starting points
            if (interval[0] > 0 && opts.num_edge_entries > 0) {

                var end = Math.min(opts.num_edge_entries + 1, interval[0]);
                appendRange(1, end);
//                for (var i = 1; i < end; i++) {
//                    appendItem(i);
//                }
                if (opts.num_edge_entries + 1 < interval[0] && opts.ellipse_text) {
                    jQuery("<li class='disabled'><a href='javascript:void(0);'>" + opts.ellipse_text + "</a></li>").appendTo(panel);
                }
            }
            // Generate interval links
//            for (var i = interval[0]; i <= interval[1]; i++) {
//                appendItem(i);
//            }
            appendRange(interval[0], interval[1]);
            // Generate ending points
            if (interval[1] < np && opts.num_edge_entries > 0) {
                if (np - opts.num_edge_entries > interval[1] && opts.ellipse_text) {
                    jQuery("<li  class='disabled'><a href='javascript:void(0);'>" + opts.ellipse_text + "</a></li>").appendTo(panel);
                }
                var begin = Math.max(np - opts.num_edge_entries, interval[1]);
//                for (var i = begin; i <= np; i++) {
//                    appendItem(i);
//                }
                appendRange(begin, np);
            }
            // Generate "Next"-Link
            if (opts.next_text && (current_page <= np || opts.next_show_always)) {
//        appendItem(current_page + 1, {text: opts.next_text, classes: "next"});
                if (current_page == np) {
                    jQuery("<li class='disabled'><span class='next_page'>" + opts.next_text + "</span></li>").appendTo(panel);
                } else {
                    appendItem(current_page + 1, {text: opts.next_text});
                }
            }
        }

        // Extract current_page from options
        var current_page = opts.current_page;
        // Create a sane value for maxentries and items_per_page
        maxentries = (!maxentries || maxentries < 0) ? 1 : maxentries;
        opts.items_per_page = (!opts.items_per_page || opts.items_per_page < 0) ? 1 : opts.items_per_page;
        // Store DOM element for easy access from all inner functions
        var panel = jQuery(this);
        // Attach control functions to the DOM element
        this.selectPage = function (page_id) {
            pageSelected(page_id);
        }
        this.prevPage = function () {
            if (current_page > 0) {
                pageSelected(current_page - 1);
                return true;
            }
            else {
                return false;
            }
        }
        this.nextPage = function () {
            if (current_page < numPages() - 1) {
                pageSelected(current_page + 1);
                return true;
            }
            else {
                return false;
            }
        }
        // When all initialisation is done, draw the links
        drawLinks();
        if (opts.call_in_first) {
            // call callback function
            opts.callback(current_page, this);
        }
    });
}


