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
      app.connected = true
    else
      app.user = null
      app.connected = false
      app.router.navigate '', true
