app.Views.Photo = Backbone.View.extend
	template: JST['photo']
	initialize: ->

	render: ->
		@$el.html(@template(photo: @model))
		this