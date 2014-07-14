/**
 * Created by wangrenhui on 14-7-10.
 */
App.Views.User = Backbone.View.extend({
    className: '.user',
    tagName: 'div',
    model: new App.Models.User(),

    initialize: function () {
        this.model.bind('change', this.render, this);
    },

    render: function () {
        $(this.el).html(_.template($('#indexTemplate').html(), this.model.get("name")));
    },

    events: {
        'click a.center': 'center'
    },

    center: function (e) {
        // Logic here
    }

});