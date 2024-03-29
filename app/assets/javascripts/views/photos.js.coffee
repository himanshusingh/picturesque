app.Views.Photos = Backbone.View.extend
  el: '#photosView'
  template: JST['photos']

  events:
    'click .upload-btn': 'uploadPhotos'
    'click .select-all': 'selectAll'
    'click .ss-login-btn': 'showModal'

  initialize: ->
    @listenTo(@collection, 'add', @renderPhoto)
    @listenTo(@collection, 'reset', @render)

  render: ->
    $('#app').addClass('hidden')
    $('#gallery').removeClass('hidden')
    $('#upload-page').addClass('hidden')
    #$('#albums').addClass('hidden')
    albumName = @options.album.get('name')
    $('#gallery .breadcrumb .active').html(albumName)
    $("div.album-title h4 span").text(albumName)
    $("div.album-title").removeClass("hidden")
    @photoDiv = @$el.find("#photos").empty()
    @photoDiv.html(@template(collection: @collection))
    @collection.each (photo) =>
      @renderPhoto photo
    this

  renderPhoto: (photo) ->
    view = new app.Views.Photo(model: photo)
    @photoDiv.append(view.render().el)

  showModal: (e) ->
    e.preventDefault()
    $(".modal").modal()

  goToAlbums: (e) ->
    e.preventDefault()
    app.router.navigate('albums', true)

  uploadPhotos: (e) ->
    e.preventDefault()
    password = $("#inputPassword1").val()
    login = $("#inputEmail1").val()
    if(password == "" || login == "")
      alert('Please enter your SlideShare login and password')
      return
    $(".modal").modal('hide')
    selectedPhotos = @collection.selectedPhotos()
    photosData = {}
    photosData.login = login
    photosData.password = password
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
          $(document).trigger('upload_id', data)
    app.router.navigate 'upload', true
    return true

    selectAll: (e) ->
      select = @$el.find(".select-all")
      if select.hasClass("icon-check")
        $(document).trigger('selectAll')
