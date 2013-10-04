app.Views.Photos = Backbone.View.extend
  el: '#photosView'
  template: JST['photos']

  events:
    'click .upload-btn': 'uploadPhotos'

  initialize: ->
    @listenTo(@collection, 'add', @renderPhoto)
    @listenTo(@collection, 'reset', @render)

  render: ->
    $('#app').addClass('hidden')
    $('#gallery').removeClass('hidden')
    #$('#albums').addClass('hidden')
    albumName = @options.album.get('name')
    $('#gallery .breadcrumb .active').html(albumName)
    $("h4.album-title span").text(albumName)
    $("h4.album-title").removeClass("hidden")
    @photoDiv = @$el.find("#photos").empty()
    @photoDiv.html(@template(collection: @collection))
    @collection.each (photo) =>
      @renderPhoto photo
    this

  renderPhoto: (photo) ->
    view = new app.Views.Photo(model: photo)
    @photoDiv.append(view.render().el)

  goToAlbums: (e) ->
    e.preventDefault()
    app.router.navigate('albums', true)

  uploadPhotos: (e) ->
    e.preventDefault()
    selectedPhotos = @collection.selectedPhotos()
    photosData = {}
    photosData.name = @options.album.get('name')
    photosData.description = @options.album.get('description')
    photosData.images = []
    for own key, photo of selectedPhotos
      console.log(photo)
      imgData = photo.get('images')[1]
      caption = photo.get('name')
      imgData.caption = caption
      photosData.images.push(imgData)
    console.log(photosData)
    $.ajax '/upload',
      type: 'POST'
      data: photosData
      success: (data) ->
          console.log(data)
    return true