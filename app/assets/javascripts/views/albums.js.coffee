app.Views.Albums = Backbone.View.extend
	template: JST['albums']

	el: '#albumsView'

	initialize: ->
		@collection.fetchAlbums()
		@listenTo(@collection, 'add', @renderAlbum)
		@listenTo(@collection, 'reset', @render)

	render: ->
		$('.pager').removeClass('hidden')
		$('.previous').removeClass('disabled')
		$('.previous').click (e) ->
			e.preventDefault()
			app.router.navigate '', true

		$('#app').addClass('hidden')
		$('#gallery').addClass('hidden')
		$('#albums').removeClass('hidden')
		$('#albumsView').selectable();

		@$el.empty()
		@$el.html(@template())

		@collection.each (album) =>
			@renderAlbum album
		this

	renderAlbum: (album) ->
		albumView = new app.Views.Album(model: album)
		@$el.append albumView.render().el