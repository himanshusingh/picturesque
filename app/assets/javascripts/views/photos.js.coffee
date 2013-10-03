app.Views.Photos = Backbone.View.extend
	el: '#photosView'
	template: JST['photos']

	initialize: ->
		@listenTo(@collection, 'add', @renderPhoto)
		@listenTo(@collection, 'reset', @render)
		$(document).on 'swap', (e) =>
			e.preventDefault()
			@swapPhotos(2, 4)

	render: ->
		$('#app').addClass('hidden')
		$('#gallery').removeClass('hidden')
		#$('#albums').addClass('hidden')
		@$el.empty()
		@$el.html(@template(collection: @collection))
		@collection.each (photo) =>
			@renderPhoto photo
		this

	renderPhoto: (photo) ->
		view = new app.Views.Photo(model: photo)
		@$el.append(view.render().el)

	goToAlbums: (e) ->
		e.preventDefault()
		app.router.navigate('albums', true)

	swapPhotos: (pos1, pos2) ->
		obj1 = @collection.find( (photo) ->
					photo.get('pos') == pos1 ).el
		obj2 = @collection.find( (photo) ->
					photo.get('pos') == pos2 ).el
		console.log(obj1)
		temp = document.createElement("div");
		obj1.parentNode.insertBefore(temp, obj1);

		# move obj1 to right before obj2
		obj2.parentNode.insertBefore(obj1, obj2)

		# move obj2 to right before where obj1 used to be
		temp.parentNode.insertBefore(obj2, temp)

		# remove temporary marker node
		temp.parentNode.removeChild(temp)