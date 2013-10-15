app.Views.Upload = Backbone.View.extend
	el: '#upload-page'
	template: JST['upload']
	initialize: ->
		$(document).on 'upload_id', (e, data) =>
      counter = 0
			t = setInterval \
				() =>
					@$('.spinner').addClass('hidden')
          if !data
            $('.fallback-url').html("www.slideshare.net/slideshow/embed_code/" + data.slideshow_id)
            @$('.alert.upload-waiting').removeClass('hidden')
            return
					if data.status == true
						@$('.waiting').addClass('hidden')
						console.log(data)
						@$('#slideshow').empty()
						@$('#slideshow').html ('<iframe src="http://www.slideshare.net/slideshow/embed_code/' + data.slideshow_id + '"' + ' width="638" height="450" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC;border-width:1px 1px 0;margin-bottom:5px" allowfullscreen> </iframe> <div style="margin-bottom:5px">')
						#@$('#slideshow_frame').attr 'src', 'http://www.slideshare.net/slideshow/embed_code/' + data.slideshow_id
						#@$('#slideshow_frame').removeClass('hidden')
						@$('#congo').removeClass('hidden')
            cleartInterval(t)
					else
						@$('.alert.upload-fail').removeClass('hidden')

				, 8000
		@$('#refresh').click () =>
			@$('#slideshow_frame').attr 'src', 'http://www.slideshare.net/slideshow/embed_code/' + data.slideshow_id

	render: ->
		$('#app').addClass('hidden')
		$('#gallery').addClass('hidden')
		$('#albums').addClass('hidden')
		$('#upload-page').removeClass('hidden')
		@$el.empty()
		$(".container.marker").addClass("hidden")
		@$el.html(@template())
