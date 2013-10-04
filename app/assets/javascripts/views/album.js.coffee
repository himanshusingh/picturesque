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
		console.log(@$el.find("span.icon-unchecked"))
		$("#albumsView .icon-check")
			.removeClass("icon-check")
			.addClass("icon-unchecked")
		@$el.find("span.icon-unchecked")
			.removeClass("icon-unchecked")
			.addClass("icon-check")
		photosView = new app.Views.Photos(collection: @model.get('photos'), album: @model)
		photosView.render()

	uploadPhotos: (e) ->
		photos = @collection.selectedPhotos();
		console.log(photos);