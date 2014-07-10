/**
 * Created by wangrenhui on 14-7-9.
 */

// 这是一个管理着 视图/控制/模型 的全局类
var App = {
    Routers: {},
    Models: {},
    Views: {},
    Collections: {},
    initialize: function () {
        var router = new App.Routers.Main();
        Backbone.history.start({pushState: true}); // 要驱动所有的Backbone程序，Backbone.history.start()是必须的。
    }
};

App.Routers.Main = Backbone.Router.extend({
    routes: {
        '': 'index',
        'register': 'register',
        'about': 'about'
    },
    index: function () {
        // Homepage  model operation
        var user1 = new App.Models.User({
            name: 'name1'
        });
        console.log(user1.get('name')); // prints 'name1'

        // 'name' attribute is set with a new value
        user1.set({
            name: 'name2'
        });
        console.log(user1.get('name'));

        var teams = new App.Collections.Users();

        teams.add(user1);
        teams.add(new App.Models.User({
            name: 'User B'
        }));
        teams.add(new App.Models.User());
        teams.remove(user1);

        console.log(teams.length);
    },
    about: function () {
        console.log('about');
    }

});