#
#Blog View
#
App.Views.Blog = Backbone.View.extend
  render: (param) ->
    $('#main').html(@$el.html(_.template($('#main_blog').html(), param)))

#---Blogs---
App.Views.Blogs = Backbone.View.extend
  events:
    "blur    .updateBlog": "updateBlog"
    "click   .deleteBlog": "deleteBlog"

  updateBlog: (event) ->
    event.preventDefault()
    model = new Blog(title: $('#blog_newtitle').val(), body: $('#blog_newbody').val())
    if model.isValid() then model.save() else window.alert model.validationError

  deleteBlog: (event) ->
    if window.confirm("Are you sure?")
      event.preventDefault()
      id = $(event.currentTarget).data('id')
      blogs.get(id).destroy()

  render: (param) ->
    @$el.html(_.template($('#main_blogs').html(), param))

  renew: ->
    $.when(
      blogs.fetch()
    ).done(->
      console.log blogs
      $('#main').html(new App.Views.Blogs().render(
        blogs: blogs
      ))
    )

