DISABLE_SUBMIT = true

App.Kinderfeest = class Kinderfeest

  constructor: ->

  # Variable that keeps track whether the height of divs has been set to auto
  autoSize: false

  ### Private methods ###
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
  getCurrentPacketPrice = ->
    return getPacketPrice(getPacketOption())
  
  getNumberOfAdults = ->
    # Retrieve number of adults.
    numberOfAdults = parseInt $('#inputAdults').val()
    # If invalid it's not a number then interpret it as 0.
    numberOfAdults = 0 if isNaN numberOfAdults
    numberOfAdults

  getNumberOfChildren = ->
    # Retrieve number of children.
    numberOfChildren = parseInt $('#inputChildren').val()
    numberOfChildren = 0 if isNaN numberOfChildren
    numberOfChildren
  
  getNumberOfPeople = ->
    return getNumberOfAdults() + getNumberOfChildren()

  getTotalPrice = ->
    totalPrice = 0.0
    
    # Adding the price for the tickets
    totalPrice += getCurrentPacketPrice() * getNumberOfPeople()
    
    # Add the price for the camera if available
    totalPrice += 9.95 if $('#checkbox-camera').is(':checked')

    # Add price for optional 3D glasses
    totalPrice += getNumberOfPeople() if $('#checkbox-3D').is(':checked') && getPacketOption() == "film"

    return totalPrice.toFixed(2)

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

  updateTablePrice = ->
    priceTable.updatePrice "Volwassenen", getCurrentPacketPrice()
    priceTable.updatePrice "Kinderen", getCurrentPacketPrice()
    return

  ### Initializers ###

  # Initializes the date picker of the form
  initializeCheckbox = ->
    $('#checkbox-3D').click ->
      if $(this).is ':checked'
        priceTable.addArticle "3D bril", getNumberOfPeople(), 1.00
      else 
        priceTable.removeArticle "3D bril"

    $('#checkbox-camera').click ->
      if $(this).is ':checked'
        priceTable.addArticle "Onderwater Camera", 1, 9.95
      else
        priceTable.removeArticle "Onderwater Camera"

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

  initializeForm = ->
    initializeDatePicker()
    initializeTimePicker()

    # If the modal is not open, then it will prevent the submissiona nd open the modal.
    # Otherwise it will submit the form.
    initializeFormSubmissionHandler()
    return
    
  # If the modal is not open, then it will prevent the submissiona nd open the modal.
  # Otherwise it will submit the form.
  initializeFormSubmissionHandler = ->
    # Causes the modal to pop instead of doing a post submission.
    $('#form-main').validator().on 'submit', (e) ->
      # Modal is open so the submission will continue.
      if $('#confirmSubmission').hasClass('in')
        # Adding attributes such as total price and summary.
        console.log "Normal submission"

        # For testing purposes only.
        e.preventDefault() if DISABLE_SUBMIT
      else
        # Normal submission, so will prevent the submission and use the popup instead.
        unless e.isDefaultPrevented()
          e.preventDefault()
          kinderPage.openModal()
        return
      return

  initializePeopleCount = ->
    $('#inputAdults').change -> 
      priceTable.updateAmount "Volwassenen", getNumberOfAdults()
      priceTable.updateAmount "3D bril", getNumberOfPeople()

    $('#inputChildren').change ->
      priceTable.updateAmount "Kinderen", getNumberOfChildren()
      priceTable.updateAmount "3D bril", getNumberOfPeople()
  
  # Initializes the popovers.
  initializePopovers = ->
    $(".info-snack").popover
      trigger: 'hover'
      content: 'Keuze uit: frikankel, kroket, kaassoufflé, ...'
      placement: 'right'

    $(".info-drink").popover
      trigger: 'hover'
      content: 'Keuze uit: Cola, Fanta, ...'
      placement: 'right'
    return

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
    updateTablePrice()
    if getPacketOption() == "film" && $('#checkbox-3D').is(':checked')
      priceTable.addArticle("3D bril", getNumberOfPeople(), 1.00)
    priceTable.removeArticle("3D bril") if getPacketOption() != "film"

  # Makes sure that the height of the divs of the three block are same height
  resizeDivs: ->
    divSameHeight $(".kinderfeest-select h3")
    divSameHeight $(".kinderfeest-select .items")
    divSameHeight $(".kinderfeest-select .checkbox")
    return

  initialize: ->
    # Initialize the popovers
    initializePopovers()

    # Initialize the forms, including date and time picker and the submission handler.
    initializeForm()

    # Initializes the checkbox
    initializeCheckbox()

    # Initializes the events that update the price on people change.
    initializePeopleCount()

    # Initialize the price boxes
    $(".kinderfeest-select .inner").on 'click', ->
      kinderPage.updateSelection $(this), $('.radio input', this)
    
    return

  # Fills in all modal info and opens it afterwards.
  openModal: ->
    # Add all the known information inside the model.
    $('#modalEmail').text $('#inputEmail').val()
    $('#modalSummary').text getDescriptionText()
    $('#modalAdults').text getNumberOfAdults()
    $('#modalChildren').text getNumberOfChildren()
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

App.Article = class Article
  constructor: (@description, @amount, @pricePerPiece) ->
    return
  
  # Get the description of the article
  getDescription: ->
    return @description
  
  # Get the amount of the article
  getAmount: ->
    return @amount

  # Get the price of the article
  getPrice: ->
    return @pricePerPiece

  # Updates the amount of the article
  updateAmount: (amount) ->
    @amount = amount
    return

  # Updates the price of the article
  updatePrice: (pricePerPiece) ->
    @pricePerPiece = pricePerPiece
    return


App.PriceTable = class PriceTable

  # Summary of the part of the price.
  # In the form of []
  summaryTable: []

  constructor: ->
  
  ### PUBLIC FUNCTIONS ###

  # Adds an article to the table
  addArticle: (description, amount, price) ->
    newArticle = new Article(description, amount, price)
    @summaryTable.push(newArticle) unless @inTable description
    @updateTable()
    return

  # Removes an article from the table
  removeArticle: (description) ->
    @summaryTable.splice(i, 1) for article, i in @summaryTable when article.getDescription() is description
    @updateTable()
    return

  inTable: (description) ->
    return true for article in @summaryTable when article.getDescription() == description
    return false

  initializeTable: ->
    # Empties the table
    @summaryTable = []

    # Adds the Volwassenen and Children articles to the table.
    volwassenArticle = new Article("Volwassenen", 0, 9.95)
    childrenArticle = new Article("Kinderen", 0, 9.95)

    @summaryTable.push(volwassenArticle) unless @inTable "Volwassenen"
    @summaryTable.push(childrenArticle) unless @inTable "Kinderen"

    $('table').append "<tr>
      <th>Omschrijving</th>
      <th>Aantal</th>
      <th>Totaal Prijs</th>
      </tr>"
    @updateTable()
    return

  # Updates the amount of the article in the table
  # Updates the table afterwards
  # NOTE: Maybe use .equals because of strings?
  updateAmount: (artDescription, amount) ->
    article.updateAmount(amount) for article in @summaryTable when article.getDescription() is artDescription
    @updateTable()
    return

  updatePrice: (artDescription, price) ->
    article.updatePrice(price) for article in @summaryTable when article.getDescription() is artDescription
    @updateTable()
    return

  updateTable: ->
    #Remove all but the first element of the table
    $('table tr').slice(1).remove() 
    
    totalPrice = 0
    # Adds the price of the current article to the total price and appends 
    # it to the table.
    for article in @summaryTable
      do (article) ->
        unless typeof article == 'undefined'
          # Retrieve info from the article
          articleDescription = article.getDescription()
          articleAmount = article.getAmount()
          articlePrice = article.getPrice()

          totalArticlePrice = articleAmount * articlePrice
          totalPrice += totalArticlePrice

          $('table').append "<tr>
            <td>#{articleDescription}</td>
            <td>#{articleAmount}</td>
            <td>&euro; #{totalArticlePrice.toFixed(2)}</td>
            </tr>"

    # Append total price
    $('table').append "<tr>
      <td>Totaal</td>
      <td></td>
      <td>&euro; #{totalPrice.toFixed(2)}</td>
      </tr>"
    return

kinderPage = new Kinderfeest()
priceTable = new PriceTable()

$(document).on "page:change", ->
  # Initializes the forms 
  kinderPage.initialize()
  priceTable.initializeTable()
  # The functions executed on page load.

  # Start with the standard kinderfeest selected
  $("#radio-standard").click()

  kinderPage.resizeDivs if $(window).width() >= 753

  # Temporary bugfix where resize does weird on particular load situation
  setTimeout(kinderPage.resizeDivs, 100) if $(window).width() >= 753



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