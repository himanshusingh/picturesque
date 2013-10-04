app.Views.Upload = Backbone.View.extend
	el: '#upload-page'
	template: JST['upload']
	initialize: ->
		$(document).on 'upload_id', (e, data) =>
			setTimeout \
				() =>
					@$('.spinner').addClass('hidden')
					if data.status == true
						@$('.waiting').addClass('hidden')
						@$('#slideshow_frame').attr 'src', 'http://www.slideshare.net/slideshow/embed_code/' + data.slideshow_id
						@$('#slideshow_frame').removeClass('hidden')
						@$('#congo').removeClass('hidden')
					else
						@$('.alert').removeClass('hidden')

				, 8000
		@$('#refresh').click () =>
			@$('#slideshow_frame').attr 'src', 'http://www.slideshare.net/slideshow/embed_code/' + data.slideshow_id

	render: ->
		$('#app').addClass('hidden')
		$('#gallery').addClass('hidden')
		$('#albums').addClass('hidden')
		$('#upload-page').removeClass('hidden')
		@$el.empty()
		@$el.html(@template())