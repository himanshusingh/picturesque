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
		photosView = new app.Views.Photos(collection: @model.get('photos'), album: @model)
		photosView.render()

	uploadPhotos: (e) ->
		photos = @collection.selectedPhotos();
		console.log(photos);