app.Views.Index = Backbone.View.extend
	el: '#appView'
	template: JST['index']

	initialize: ->

	events:
		'click #fblogin': 'login'
		'click #enter'	: 'enter'

	render: ->

		$('#app').removeClass('hidden')
		$('#gallery').addClass('hidden')
		$('#albums').addClass('hidden')
		$('#upload-page').addClass('hidden')
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
			,scope: 'user_photos','email','friends_photos','publish_actions'

	enter: (e) ->
		e.preventDefault()
		app.router.navigate 'albums', true

