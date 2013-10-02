app.Views.Photos = Backbone.View.extend
	el: '#app'

	initialize: ->
		@listenTo(@collection, 'add', @renderPhoto)
		@listenTo(@collection, 'reset', @render)

	render: ->
		console.log('here')
		@$el.empty()
		@collection.each (photo) =>
			@renderPhoto photo
		this

	renderPhoto: (photo) ->
		view = new app.Views.Photo(model: photo)
		@$el.append(view.render().el)