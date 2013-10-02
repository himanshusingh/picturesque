app.Collections.Albums = Backbone.Collection.extend
	model: 'album'

	fetchAlbums: () ->
		if app.albums.size() == 0
			FB.api '/me/albums', (response) =>
				for info in response.data
			    	@addAlbum info

	addAlbum: (info) ->
		console.log(info)
		FB.api '/'+info.id+'/picture', (response) =>
			info.cover = response.data.url
			info.photos = new app.Collections.Photos([], id: info.id)
			@add new app.Models.Album info