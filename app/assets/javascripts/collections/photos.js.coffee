app.Collections.Photos = Backbone.Collection.extend
	model: 'photo'

	initialize: (models, options) ->
		@id = options.id
		@fetchPhotos()

	fetchPhotos: () ->
		console.log(@id)
		FB.api @id + '/photos?limit=200', (response) =>
			for info in response.data
				@add new app.Models.Photo info
			console.log(@size())
