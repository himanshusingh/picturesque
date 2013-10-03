app.Models.Album = Backbone.Model.extend
	initialize: ->

	getData: ->
		data = {}
		data.user = app.user
		data.name = @get('name')
		data.description = @get('description')
		data.pictures = @get('photos').selectedPhotos()
		data

	sendData: ->
		


