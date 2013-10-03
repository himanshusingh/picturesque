app.Collections.Photos = Backbone.Collection.extend
	model: 'photo'

	initialize: (models, options) ->
		@id = options.id
		@fetchPhotos()

	fetchPhotos: () ->
		counter = 0
		FB.api @id + '/photos?limit=200', (response) =>
			if response.data
				for info in response.data
					++counter
					info.pos = counter
					info.selected = true
					@add new app.Models.Photo info

	selectedPhotos: () ->
		@filter (model) ->
			model.get('selected') == true

	sortByPos: () ->
		@sortBy (model) ->
			model.get('pos')
