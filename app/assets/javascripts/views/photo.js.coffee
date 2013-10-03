app.Views.Photo = Backbone.View.extend
	template: JST['photo']

	events:
		'click' 	: 'enlargeImage'
		'mouseenter': 'showOverlay'
		'mouseleave': 'hideOverlay'
	initialize: ->

	render: ->
		@$el.html(@template(photo: @model))
		this

	enlargeImage: (e) ->

	showOverlay: (e) ->
		@$('.caption')

	hideOverlay: (e) ->
		@$('#photo-div')

