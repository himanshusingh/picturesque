app.Views.Index = Backbone.View.extend
	template: JST['index']

	initialize: ->

	events:
		'click #fblogin': 'login'

	render: ->
		@setElement(@template())
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

