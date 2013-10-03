app.Views.Photo = Backbone.View.extend
	template: JST['photo']

	events:
		'click' : 'enlargeImage'
	initialize: ->

	render: ->
		@$el.html(@template(photo: @model))
		this

	enlargeImage: (e) ->
