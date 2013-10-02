app.Collections.Photos = Backbone.Collection.extend
	model: 'photo'

	initialize: (models, options) ->
		@id = options.id
		@fetchPhotos()

	fetchPhotos: () ->
		FB.api @id + '/photos?limit=200', (response) =>
			if response.data
				for info in response.data
					@add new app.Models.Photo info
