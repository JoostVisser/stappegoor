App.Kinderfeest =
  # Makes sure that the height of the divs of the three block are same height
  resizeDivs: ->
    App.Kinderfeest.divSameHeight $(".kinderfeest-select h3")
    App.Kinderfeest.divSameHeight $(".kinderfeest-select .items")
    App.Kinderfeest.divSameHeight $(".kinderfeest-select .checkbox")
    return

  # Puts the height to auto
  autoDivs: ->
    $(".kinderfeest-select h3").height('auto')
    $(".kinderfeest-select .items").height('auto')
    $(".kinderfeest-select .checkbox").height('auto')
    return

  # Variable that keeps track whether the height of divs has been set to auto
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

  # Updates the enter action of the form to validate & spawn model.
  formEnterAction: ->
    $('form').on 'keypress', (event) ->
      if event.which == 13 and $(event.target).is(':input')
        event.preventDefault()
        test = $(this).validator('validate')
        App.Kinderfeest.openModal()
      return

  initializeDatePicker: ->
    # Options of the datepicker.
    $('.datepicker').datepicker({
      language: 'nl',
      format: "d MM yyyy",
      autoclose: true
    });

  openModal: ->
    console.log("Opens Modal")
    return

  updateRadio: ($radio) ->
    $(".kinderfeest-select .inner .radio .input")
      .prop "checked", false
    $radio.prop "checked", true

  # Updates the border from dashed to solid for the selected and others to dashed.
  updateStyle: ($selectedDiv) ->
    # Update all borders to dashed
    $(".kinderfeest-select .inner")
      .css "background-color", App.Colours.darkBlue(0.2)

    $(".kinderfeest-select .inner .items")
      .css "background-color", 'rgba(255, 255, 255, 0.9)'
    # Update the chosen one to solid
    $selectedDiv
      .css "background-color", App.Colours.darkBlue(0.5)
    $(".items", $selectedDiv)
      .css "background-color", 'rgba(255, 255, 255, 1)'
    return

  updatePrize: (type) ->
    console.log type
    return

# The functions executed on page load.
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
  $("#radio-standard").click()

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

  App.Kinderfeest.initializeDatePicker()

  $('#main-form').validator().on 'submit', (e) ->
    if ! e.isDefaultPrevented()
      e.preventDefault()
      $("#confirmSubmission").modal('show');
    return

  return

# Changes the divs-height on window resize
$(window).resize ->
  if $(window).width() >= 753
    App.Kinderfeest.resizeDivs()
    App.Kinderfeest.autoSize = false
  # Puts size on auto-size when the window is small, only fires this events once.
  else if !App.Kinderfeest.autoSize
    App.Kinderfeest.autoSize = true
    App.Kinderfeest.autoDivs()
  return