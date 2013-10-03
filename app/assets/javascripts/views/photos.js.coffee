app.Views.Photos = Backbone.View.extend
  el: '#photosView'
  template: JST['photos']

  events:
    'click': 'uploadPhotos'

  initialize: ->
    @listenTo(@collection, 'add', @renderPhoto)
    @listenTo(@collection, 'reset', @render)

  render: ->
    $('#app').addClass('hidden')
    $('#gallery').removeClass('hidden')
    #$('#albums').addClass('hidden')
    $('#gallery .breadcrumb .active').html(@options.album.get('name'))
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
    photosData.user = app.user
    photosData.name = @options.album.get('name')
    photosData.description = @options.album.get('description')
    photosData.photos = selectedPhotos
    $.ajax 'localhost:3000/upload',
      type: 'POST'
      data: photosData
      error: (jqXHR, textStatus, errorThrown) ->
          $('body').append "AJAX Error: #{textStatus}"
      success: (data, textStatus, jqXHR) ->
          $('body').append "Successful AJAX call: #{data}"
    return true

