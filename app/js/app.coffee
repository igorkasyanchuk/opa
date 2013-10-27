$ ->
  $(document).on "pageshow", ".ui-page", ->
    $page = $(this)
    vSpace = $page.children(".ui-header").outerHeight() + $page.children(".ui-footer").outerHeight() + $page.children(".ui-content").height()

    if vSpace < $(window).height()
      vDiff = $(window).height() - $page.children(".ui-header").outerHeight() - $page.children(".ui-footer").outerHeight() - 28
      $page.children(".ui-content").height vDiff

  $('#main').trigger("pageshow")

$(document).on "pageinit", ->

  $('#main').on "swiperight", ->
    $.mobile.changePage("#search")

  $('#main').on "swipeleft", ->
    $.mobile.changePage("/")
