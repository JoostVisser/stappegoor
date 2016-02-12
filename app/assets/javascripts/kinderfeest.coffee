App.Kinderfeest =
  # Updates the border from dashed to solid for the selected and others to dashed.
  updateBorder: ($selected) ->
    # Update all borders to dashed
    $(".kinderfeest-select .inner")
      .css "border", "1px dashed rgba(0, 0, 0, 0.7)"

    # Update the chosen one to solid
    $selected.parents(".inner")
      .css "border", "1px solid rgba(0, 0, 0, 0.7)"
    return

  updatePrize: (type) ->
    console.log type
    return

$(document).on "page:change", ->
  $(".kinderfeest-select :input").change ->
    App.Kinderfeest.updateBorder($(this))
    App.Kinderfeest.updatePrize $('input[name=kinderfeest-type]:checked', ".kinderfeest-select").val()
    return
  return