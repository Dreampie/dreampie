# 这是一个管理着 视图/控制/模型 的全局类
#http://documentcloud.github.io/backbone
App = {
  Routers: {}
  Models: {}
  Views: {}
  Collections: {}
  initialize: ->
    appRouter = new App.Routers.Main()
    # 要驱动所有的Backbone程序，Backbone.history.start()是必须的。
    Backbone.history.start
      pushState: true
}
# ----main routers-----

App.Routers.Main = Backbone.Router.extend
  routes:
    '': 'index'
    'about': 'about'

    index: ->
      App.Views.Index.render()
    about: ->
      App.Views.About.render()

App.Views.Index = Backbone.View.extend
  render: (param) ->
    $('#main').html(@$el.html(_.template($('#main_index').html(), param)))

App.Views.About = Backbone.View.extend
  render: (param) ->
    $('#main').html(@$el.html(_.template($('#main_about').html(), param)))


# --- Initialize ---
$ ->
  App.initialize()