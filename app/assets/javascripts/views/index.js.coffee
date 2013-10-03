app.Views.Index = Backbone.View.extend
	el: '#appView'
	template: JST['index']

	initialize: ->

	events:
		'click #fblogin': 'login'
		'click #enter'	: 'login'

	render: ->

		$('#app').removeClass('hidden')
		$('#gallery').addClass('hidden')
		$('#albums').addClass('hidden')
		@$el.empty()
		@$el.append(@template($(".index-template").html()))
		this

	login: (e) ->
		e.preventDefault()
		FB.login \
			(response) ->
				if response.authResponse
					FB.api '/me', (response) ->
					    app.user = response
					app.connected = true

					app.router.navigate 'albums', true
			scope: 'user_photos'

