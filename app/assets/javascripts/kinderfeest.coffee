App.Kinderfeest =
  resizeDivs: ->
    App.Kinderfeest.divSameHeight $(".kinderfeest-select h3")
    App.Kinderfeest.divSameHeight $(".kinderfeest-select .items")
    App.Kinderfeest.divSameHeight $(".kinderfeest-select .checkbox")
    return

  autoDivs: ->
    $(".kinderfeest-select h3").height('auto')
    $(".kinderfeest-select .items").height('auto')
    $(".kinderfeest-select .checkbox").height('auto')
    return

  autoSize: false

  divSameHeight: ($divTarget) ->
    bestHeight = 0
    $divTarget.each ->
      $(this).height('auto')
      bestHeight = $(this).height() if $(this).height() > bestHeight
      return

    $divTarget.each ->
      $(this).height(bestHeight)
      return
    return

  updateRadio: ($radio) ->
    $(".kinderfeest-select .inner .radio .input")
      .prop "checked", false
    $radio.prop "checked", true

  # Updates the border from dashed to solid for the selected and others to dashed.
  updateStyle: ($selectedDiv) ->
    # Update all borders to dashed
    $(".kinderfeest-select .inner")
      .css "background-color", App.Colours.clearBlue(0.3)

    $(".kinderfeest-select .inner .items")
      .css "background-color", 'rgba(255, 255, 255, 0.9)'
    # Update the chosen one to solid
    $selectedDiv
      .css "background-color", App.Colours.clearBlue(0.7)
    $(".items", $selectedDiv)
      .css "background-color", 'rgba(255, 255, 255, 1)'

    return

  updatePrize: (type) ->
    console.log type
    return

$(document).on "page:change", ->
  $(".kinderfeest-select .inner").on 'click', ->
    $myRadio = $('.radio input', this)
    # Do nothing if it's already checked.
    return if $myRadio.is ':checked'

    App.Kinderfeest.updateRadio $myRadio
    App.Kinderfeest.updateStyle $(this)
    App.Kinderfeest.updatePrize $('input[name=kinderfeest-type]:checked', ".kinderfeest-select").val()
    return

  # Start with the standard kinderfeest selected
  $("#radio-standard").click();

  $(".info-snack").popover
    trigger: 'hover'
    content: 'Keuze uit: frikankel, kroket, kaassoufflé, ...'
    placement : 'top'

  $(".info-drink").popover
    trigger: 'hover'
    content: 'Keuze uit: Cola, Fanta, ...'
    placement : 'top'

  App.Kinderfeest.resizeDivs if $(window).width() >= 753

  # Temporary bugfix where resize does weird on particular load situation
  setTimeout(App.Kinderfeest.resizeDivs, 100) if $(window).width() >= 753

  return

$(window).resize ->
  if $(window).width() >= 753
    App.Kinderfeest.resizeDivs()
    App.Kinderfeest.autoSize = false
  else if !App.Kinderfeest.autoSize
    App.Kinderfeest.autoSize = true
    App.Kinderfeest.autoDivs()
  return