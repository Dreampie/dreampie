var App;

App = {
  Routers: {},
  Models: {},
  Views: {},
  Collections: {},
  initialize: function() {
    var appRouter;
    appRouter = new App.Routers.Main();
    return Backbone.history.start({
      pushState: true
    });
  }
};

App.Routers.Main = Backbone.Router.extend({
  routes: {
    '': 'index',
    'about': 'about',
    index: function() {
      return App.Views.Index.render();
    },
    about: function() {
      return App.Views.About.render();
    }
  }
});

App.Views.Index = Backbone.View.extend({
  render: function(param) {
    return $('#main').html(this.$el.html(_.template($('#main_index').html(), param)));
  }
});

App.Views.About = Backbone.View.extend({
  render: function(param) {
    return $('#main').html(this.$el.html(_.template($('#main_about').html(), param)));
  }
});

$(function() {
  return App.initialize();
});
