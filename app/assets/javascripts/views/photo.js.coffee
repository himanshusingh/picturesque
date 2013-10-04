app.Views.Photo = Backbone.View.extend
  template: JST['photo']

  events:
    'click'   : 'selectImage'
    'click .icon-edit'   : 'editCaption'
    'blur .caption-edit'  : 'saveCaption'
    'mouseenter': 'showEdit'
    'mouseleave': 'hideEdit'
  initialize: ->
    $(document).on 'selectAll', (e) =>
      selectImage()

  render: ->
    @setElement(@template(photo: @model))
    this

  selectImage: (e) ->
    check = @$el.find("span.icon-check")
    uncheck = @$el.find("span.icon-unchecked")
    if check.length > 0
      check.removeClass("icon-check")
      check.addClass("icon-unchecked")
      @model.set({selected: false})
    else if uncheck.length > 0
      uncheck.removeClass("icon-unchecked")
      uncheck.addClass("icon-check")
      @model.set({selected: true})

  showEdit: (e) ->
    @$('.icon-edit').removeClass("hidden");

  hideEdit: (e) ->
    @$('.icon-edit').addClass("hidden");

  editCaption: (e) ->
    e.stopImmediatePropagation()
    input = @$el.find(".caption-edit")
    if input.length > 0
      input.focus()
      return
    captionBox = @$el.find(".photo-comment")
    captionBox.addClass("hidden")
    input = $('<input/>').appendTo(@$el.find(".photo-caption"))
      .attr("type","text")
      .addClass("pull-left")
      .addClass("caption-edit")
      .attr("value", captionBox.text())
      .css("background", "transparent")
      .css("border", "none")
      .css("color", "inherit")
    @$el.find(".icons-right").removeClass("hidden")
    input.focus()

  saveCaption: (e) ->
    e.stopImmediatePropagation()
    input = @$el.find(".caption-edit")
    if input.length < 0
      return
    captionBox = @$el.find(".photo-comment")
    newText = input.val()
    console.log(@model)
    @model.set({"name": newText})
    captionBox.text(newText)
    input.remove()
    captionBox.removeClass("hidden")
    @$el.find(".icons-right").addClass("hidden")