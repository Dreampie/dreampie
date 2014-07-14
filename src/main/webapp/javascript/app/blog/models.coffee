#
#Blog Model
#
App.Models.Blog = Backbone.Model.extend
  initialize: ->
    @on('sync', ->
      new App.Views.Blogs().renew())
  urlRoot: '/blog'
  validate: (attrs, options) -> 'name is required' unless attrs.name
  addBlog: ->
    route = '/blog/add'
    $.ajax url: route.url, type: route.method,
      success: (response) =>
        console.log "POST /blog/add success (status: #{response.statusText})"
      error: (response) =>
        console.log "POST /blog/add failure (status: #{response.statusText})"


# ---Blogs---
App.Models.Blogs = Backbone.Collection.extend
  url: '/blog'
  model: App.Models.Blog
  parse: (data) ->
    # 'data' contains the raw JSON object
    console.log(data)
    data.blogs

