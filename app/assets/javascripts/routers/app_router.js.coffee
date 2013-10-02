app.Routers.App = Backbone.Router.extend
	routes:
		''			: 'index'
		'albums'	: 'albums'
		'album/:id'	: 'showAlbum'

	initialize: ->

	index: ->
		view = new app.Views.Index()
		$('#app').html view.render().el

	albums: ->
		if !app.connected
			@navigate('', true)
		else
			view = new app.Views.Albums(collection: app.albums)
			view.render()

	showAlbum: (id) ->
		console.log('what!')
		view = new app.Views.Photos
							collection: app.albums.get(id).get('photos')
							album: app.albums.get(id)
		view.render()