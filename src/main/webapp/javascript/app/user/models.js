/**
 * Created by wangrenhui on 14-7-10.
 */
App.Models.User = Backbone.Model.extend({
    urlRoot: "/user",
    defaults: {
        name: ""
    },

    initialize: function () {
        this.bind("change", this.changed);
    },

    validate: function (attributes) {
        if (!!attributes && attributes.name === "teamX") {
            return "Error!";
        }
    },

    changed: function () {
        console.log("changed");
    }
});


App.Collections.Users = Backbone.Collection.extend({
    model: App.Models.User
});
