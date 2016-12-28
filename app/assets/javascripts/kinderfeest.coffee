DISABLE_SUBMIT = false

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

  getFullPacketDescription = ->
    packetDescription = getDescriptionText();

    if is3DCheckedWithFilm() && isCameraChecked()
      packetDescription += " met 3D brillen en onderwatercamera."
    else if is3DCheckedWithFilm()
      packetDescription += " met 3D brillen."
    else if isCameraChecked()
      packetDescription += " met onderwatercamera."
    else
      packetDescription += "."

  getPacketOption = ->
    return $('input[name=kinderfeest-type]:checked', ".kinderfeest-select").val()

  getPacketPrice = (packetValue) ->
    switch(packetValue)
      when "standard"
        App.Prices.STANDARD
      when "luxe"
        App.Prices.LUXE
      when "film"
        App.Prices.FILM


  getCurrentPacketPrice = ->
    return getPacketPrice(getPacketOption())
  
  getNumberOfPersons = ->
    # Retrieve number of adults.
    numberOfAdults = parseInt $('#inputNrOfPersons').val()
    # If invalid it's not a number then interpret it as 0.
    numberOfAdults = 0 if isNaN numberOfAdults
    numberOfAdults

  getNumberOfDiscounts = ->
    # Retrieve number of children.
    numberOfChildren = parseInt $('#inputNrOfDiscounts').val()
    numberOfChildren = 0 if isNaN numberOfChildren
    numberOfChildren
  
  getTotalNumberOfPeople = ->
    return getNumberOfPersons() + getNumberOfDiscounts()

  getTotalPrice = ->
    totalPrice = 0.0
    
    # Adding the price for the tickets
    totalPrice += getCurrentPacketPrice() * getNumberOfPersons()
    totalPrice += (getCurrentPacketPrice() - App.Prices.SPECIAL_DISCOUNT) * getNumberOfDiscounts()
    
    # Add the price for the camera if available
    totalPrice += App.Prices.CAMERA if isCameraChecked()

    # Add price for optional 3D glasses
    totalPrice += getTotalNumberOfPeople() if is3DCheckedWithFilm()

    return totalPrice.toFixed(2)

  is3DCheckedWithFilm = ->
    $('#checkbox-3D').is(':checked') && getPacketOption() == "film"

  isCameraChecked = ->
    $('#checkboxCamera').is(':checked')

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
    priceTable.updatePrice "Personen", getCurrentPacketPrice()
    priceTable.updatePrice "Personen met korting", getCurrentPacketPrice() - App.Prices.SPECIAL_DISCOUNT
    return

  ### Initializers ###

  # Initializes the date picker of the form
  initializeCheckbox = ->
    $('#checkbox-3D').click ->
      if $(this).is ':checked'
        priceTable.addArticle "3D bril", getTotalNumberOfPeople(), 1.00
      else 
        priceTable.removeArticle "3D bril"

    $('#checkboxCamera').click ->
      if $(this).is ':checked'
        priceTable.addArticle "Onderwater Camera", 1, App.Prices.CAMERA
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
    initializeTimePickers()

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

    # Using a different way of submitting because IE cannot handle buttons 
    # outside of the forms.
    $("#submitButton").on 'click', ->
      $('#form-main').submit()
      return

  initializePeopleCount = ->
    $('#inputNrOfPersons').change -> 
      priceTable.updateAmount "Personen", getNumberOfPersons()
      priceTable.updateAmount "3D bril", getTotalNumberOfPeople()

    $('#inputNrOfDiscounts').change ->
      priceTable.updateAmount "Personen met korting", getNumberOfDiscounts()
      priceTable.updateAmount "3D bril", getTotalNumberOfPeople()
  
  # Initializes the popovers.
  initializePopovers = ->
    $('.info-food').popover
      trigger: 'hover'
      content: 'Geen zin in friet met een snack? Kies dan uit: pannenkoeken, belegd pistoletje of een salade.'
      placement: 'top'
      container: 'body' 

    $(".info-snack").popover
      trigger: 'hover'
      content: 'Keuze uit: frikandel, kroket, kaassoufflé of halal frikandel'
      placement: 'top'
      container: 'body'

    $(".info-drink").popover
      trigger: 'hover'
      content: 'Keuze uit: Coca Cola (Light), Fanta, Sprite, Capri-Sun, Chaudfontaine Blauw, koffie, thee of cappuccino.'
      placement: 'top'
      container: 'body'

    $(".info-discount").popover
      trigger: 'hover'
      content: 'Voor abbonnementhouders, tjippas houders en actietarieven geldt € ' + App.Prices.SPECIAL_DISCOUNT.toFixed(2).replace('.',',')  + ' korting.'
    return

  # Initializes the time picker of the form
  initializeTimePickers = ->
    # Options for the ArrivalTime timepicker
    $('#form-main #inputArrivalTime').timepicker({
      defaultTime: '14:00',
      minuteStep: 15,
      showMeridian: false
    })

    # Options for the eating time timepicker
    $('#form-main #inputTime').timepicker({
      defaultTime: '17:00',
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
      priceTable.addArticle("3D bril", getTotalNumberOfPeople(), App.Prices.GLASSES)
    priceTable.removeArticle("3D bril") if getPacketOption() != "film"

  # Makes sure that the height of the divs of the three block are same height
  resizeDivs: ->
    divSameHeight $(".kinderfeest-select .inner h3")
    divSameHeight $(".kinderfeest-select .inner .items")
    divSameHeight $(".kinderfeest-select .inner .checkbox")
    return

  initialize: ->
    # Initialize the popovers
    initializePopovers()

    # Initialize the forms, including date and time picker and the submission handler.
    initializeForm()

    # Initializes the checkboxes
    initializeCheckbox()

    # Initializes the events that update the price on people change.
    initializePeopleCount()

    # Initialize the price boxes
    $(".kinderfeest-select .inner").on 'click', ->
      kinderPage.updateSelection $(this), $('.radio input', this)
    
    return

  # Fills in all modal info and opens it afterwards.
  openModal: ->
    # Add full packet description to hidden field.
    $('#packetType').attr('value', getFullPacketDescription())

    # Add all the known information inside the model.
    $('#modalName').text $('#inputName').val()
    $('#modalBirthdayBoyName').text $('#inputBirthdayBoyName').val()
    $('#modalEmail').text $('#inputEmail').val()
    $('#modalPhone').text $('#inputPhone').val()
    $('#modalSummary').text getFullPacketDescription()
    $('#modalNrOfPersons').text getNumberOfPersons()
    $('#modalNrOfDiscounts').text getNumberOfDiscounts()
    $('#modalPrice').text '\u20AC ' + getTotalPrice()
    $('#modalDate').text $('#inputDate').val()
    $('#modalArrivalTime').text $('#inputArrivalTime').val()
    $('#modalTime').text $('#inputTime').val()
    $('#modalExtra').text $('#inputExtra').val()

    # Show the modal.
    $("#confirmSubmission").modal('show');
    return

  # Puts the height to auto
  autoDivs: ->
    $(".kinderfeest-select .inner h3").height('auto')
    $(".kinderfeest-select .inner .items").height('auto')
    $(".kinderfeest-select .inner .checkbox").height('auto')
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
    normalArticle = new Article("Personen", 0, App.Prices.STANDARD)
    discountArticle = new Article("Personen met korting", 0, App.Prices.STANDARD - App.Prices.SPECIAL_DISCOUNT)

    @summaryTable.push(normalArticle) unless @inTable "Personen"
    @summaryTable.push(discountArticle) unless @inTable "Personen met korting"

    $('.summary-view table').append "<tr>
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
    $('.summary-view table tr').slice(1).remove() 
    
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

          $('.summary-view table').append "<tr>
            <td>#{articleDescription}</td>
            <td>#{articleAmount}</td>
            <td>€ #{totalArticlePrice.toFixed(2).replace('.',',')}</td>
            </tr>"

    # Append total price
    $('.summary-view table').append "<tr>
      <td>Totaal</td>
      <td></td>
      <td>€ #{totalPrice.toFixed(2).replace('.',',')}</td>
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