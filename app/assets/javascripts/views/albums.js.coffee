app.Views.Albums = Backbone.View.extend
	template: JST['albums']

	el: '#app'

	initialize: ->
		console.log(@collection)
		@collection.fetchAlbums()
		@listenTo(@collection, 'add', @renderAlbum)
		@listenTo(@collection, 'reset', @render)

	render: ->
		@$el.empty()
		
		@$el.fadeOut 'fast', () =>
			@$el.empty()
			@$el.html(@template())
			@$el.fadeIn 'fast'

		@collection.each (album) =>
			@renderAlbum album
		this

	renderAlbum: (album) ->
		albumView = new app.Views.Album(model: album)
		@$el.append albumView.render().el