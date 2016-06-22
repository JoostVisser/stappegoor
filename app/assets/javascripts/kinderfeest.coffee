App.Kinderfeest = class Kinderfeest

  constructor: ->

  # Variable that keeps track whether the height of divs has been set to auto
  autoSize: false

  # --- Private methods ---
  # Makes the divs the same height
  divSameHeight = ($divTarget) ->
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
#  formEnterAction: ->
#    $('form').on 'keypress', (event) ->
#      if event.which == 13 and $(event.target).is(':input')
#        event.preventDefault()
#        test = $(this).validator('validate')
#        Kinderfeest.openModal()
#      return

  getDescriptionText = ->
    packetOption = getPacketOption()
    switch(packetOption)
      when "standard"
        "Standaard Zwemfeestje"
      when "luxe"
        "Luxe Zwemfeestje"
      when "film"
        "Film en Zwemfeestje"

  getPacketOption = ->
    return $('input[name=kinderfeest-type]:checked', ".kinderfeest-select").val()

  getPacketPrice = (packetValue) ->
    switch(packetValue)
      when "standard"
        9.95
      when "luxe"
        12.75
      when "film"
        16.95

  getNumberOfPeople = ->
    numberOfPeople = parseInt($('#inputAdults').val()) + parseInt($("#inputChildren").val())
    if isNaN(numberOfPeople)
      0
    else
      numberOfPeople;

  getTotalPrice = ->
    (getPacketPrice(getPacketOption()) * getNumberOfPeople()).toFixed(2);

  updateRadio = ($radio) ->
    $(".kinderfeest-select .inner .radio .input")
      .prop "checked", false
    $radio.prop "checked", true

  # Updates the border from dashed to solid for the selected and others to dashed.
  updateStyle = ($selectedDiv) ->
    # Update all borders to dashed
    $(".kinderfeest-select .inner")
      .css "background-color", App.Colours.darkBlue(0.15)

    $(".kinderfeest-select .inner .items")
      .css "background-color", 'rgba(255, 255, 255, 0.9)'
    # Update the chosen one to solid
    $selectedDiv
      .css "background-color", App.Colours.darkBlue(0.65)
    $(".items", $selectedDiv)
      .css "background-color", 'rgba(255, 255, 255, 1)'
    return

  updatePrize = ->
    console.log getPacketOption()
    return

  # Initializes the date picker of the form
  initializeDatePicker = ->
    # Options of the datepicker.
    $datepicker = $('#form-main .datepicker')
    $datepicker.datepicker({
      language: 'nl',
      format: "dd-mm-yyyy",
      autoclose: true,
      disableTouchKeyboard: true,
      startDate: '0d'
    });

  # Initializes the time picker of the form
  initializeTimePicker = ->
    # Options for the timepicker
    $('#form-main #inputTime').timepicker({
      defaultTime: '12:30',
      minuteStep: 15,
      showMeridian: false
    })



  # --- Public / Prototype methods ---

  updateSelection: ($selectedDiv, $myRadio) ->
    # Do nothing if it's already checked.
    return if $myRadio.is ':checked'

    updateRadio $myRadio
    updateStyle $selectedDiv
    updatePrize

  # Makes sure that the height of the divs of the three block are same height
  resizeDivs: ->
    divSameHeight $(".kinderfeest-select h3")
    divSameHeight $(".kinderfeest-select .items")
    divSameHeight $(".kinderfeest-select .checkbox")
    return

  initializeForm: ->
    initializeDatePicker()
    initializeTimePicker()

  # Fills in all modal info and opens it afterwards.
  openModal: ->
    # Add all the known information inside the model.
    $('#modalEmail').text $('#inputEmail').val()
    $('#modalSummary').text getDescriptionText()
    $('#modalAdults').text $('#inputAdults').val()
    $('#modalChildren').text $('#inputChildren').val()
    $('#modalPrice').text '\u20AC ' + getTotalPrice()
    $('#modalDate').text $('#inputDate').val()
    $('#modalTime').text $('#inputTime').val()
    $('#modalExtra').text $('#inputExtra').val()

    # Show the modal.
    $("#confirmSubmission").modal('show');
    return

  # Puts the height to auto
  autoDivs: ->
    $(".kinderfeest-select h3").height('auto')
    $(".kinderfeest-select .items").height('auto')
    $(".kinderfeest-select .checkbox").height('auto')
    return


kinderPage = new Kinderfeest()

$(document).on "page:change", ->
# The functions executed on page load.

  $(".kinderfeest-select .inner").on 'click', ->
    kinderPage.updateSelection $(this), $('.radio input', this)
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

  kinderPage.resizeDivs if $(window).width() >= 753

  # Temporary bugfix where resize does weird on particular load situation
  setTimeout(kinderPage.resizeDivs, 100) if $(window).width() >= 753

  # Initialize date and time picker for the form.
  kinderPage.initializeForm()

  $('#form-main').validator().on 'submit', (e) ->
    if ! e.isDefaultPrevented()
      e.preventDefault()

      kinderPage.openModal()
    return

  return

# Changes the divs-height on window resize
$(window).resize ->
  if $(window).width() >= 753
    kinderPage.resizeDivs()
    kinderPage.autoSize = false
  # Puts size on auto-size when the window is small, only fires this events once.
  else unless kinderPage.autoSize
    kinderPage.autoSize = true
    kinderPage.autoDivs()
  return