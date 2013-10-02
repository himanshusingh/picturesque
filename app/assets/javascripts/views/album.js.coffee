app.Views.Album = Backbone.View.extend
	template: JST['album']

	events:
		'click': 'showAlbumPhotos'

	initialize: ->
		@listenTo(@model, 'change', @render)

	render: ->
		@setElement(@template(album: @model))
		this

	showAlbumPhotos: (e) ->
		app.router.navigate('album/' + @model.id, true)