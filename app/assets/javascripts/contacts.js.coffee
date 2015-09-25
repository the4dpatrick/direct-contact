opts =
  lines: 9
  length: 0
  width: 15
  radius: 20
  corners: 1.0
  rotate: 0
  trail: 34
  speed: 0.9
  direction: 1
  color: '#fff'
  shadow: true

submitSearch = ->
  if $('#spinner').css('display') == 'none'
    $('#spinner').toggle()
  target = document.getElementById('spinner')
  spinner = new Spinner(opts).spin(target)

$(->
  $("form[data-remote]")
  .bind('ajax:before', submitSearch)
)
$(document).on "click", '#search-form-button', ->
  $('#search-form').submit()
  $("#search-form-button").attr "disabled", true

if history && history.pushState
  $(->
  $("ul .right a").on "click", ->
    history.pushState {}, document.title, this.attr('href')
    return
  $(window).on "popstate", ->
    $.get document location.href
  )
