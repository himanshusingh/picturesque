window.app =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
      app.router = new app.Routers.App()
      app.albums = new app.Collections.Albums()
      Backbone.history.start()

$(document).ready ->
  app.initialize()
  app.user = null
  app.connected = false

  $(document).on 'fbStatusChange', (e, response) ->
  	console.log(response)
  	if response.status == 'connected'
      FB.api '/me', (response) ->
          app.user = response
          $('.navbar-text strong').html(response.name+" ")
          $('.navbar-text').removeClass('hidden')
      app.connected = true
      Backbone.history.loadUrl(Backbone.history.fragment);
    else
      app.user = null
      app.connected = false
      app.router.navigate '', true

  $('.go-to-albums').click (e) ->
    e.preventDefault()
    app.router.navigate('albums', true)

  $('.go-to-home').click (e) ->
    e.preventDefault()
    app.router.navigate('', true)

  $('#logout').click (e) ->
    e.preventDefault()
    FB.logout (response) ->
    app.connected = false
    $('.navbar-text strong').empty()
    $('.navbar-text').addClass('hidden')
    app.router.navigate '', true

  $('.upload-btn').click (e) ->
    e.preventDefault()
    