app.Views.Photo = Backbone.View.extend
  template: JST['photo']

  events:
    'click'   : 'selectImage'
    'click .icon-edit'   : 'editCaption'
    'mouseenter': 'showEdit'
    'mouseleave': 'hideEdit'
  initialize: ->

  render: ->
    @$el.html(@template(photo: @model))
    this

  selectImage: (e) ->
    check = @$el.find("span.icon-check")
    uncheck = @$el.find("span.icon-unchecked")
    if check.length > 0
      check.removeClass("icon-check")
      check.addClass("icon-unchecked")
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
    captionBox = @$.find(".caption")
    captionBox.removeClass("hidden")
    @$('<input/>').after(captionBox)
      .attr("type","text")
      .addClass("pull-left")
      .attr("value", captionBox.text())
      .css("background", "transparent")
      .css("border", "none")
      .css("color", "inherit")