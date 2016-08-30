module FormHelper
  def date_tag
    label_tag :inputDate, "Datum", class: 'control-label'
  end

  def date_field
    text_field_tag  :inputDate, 
                    nil, 
                    class: "form-control datepicker",
                    placeholder: 'dd-mm-jjjj',
                    'data-error': "Vul een correcte tijd in",
                    required: ""
  end

  def email_tag
    label_tag :inputEmail, "Email", class: 'control-label'
  end

  def email_field
    email_field_tag :inputEmail, 
                    nil,
                    class: 'form-control', 
                    placeholder: "Email",
                    pattern: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
                    'data-error': "Email adres is incorrect.",
                    required: ""
  end

  def time_tag
    label_tag :inputTime, "Voorkeur Etenstijd", class: 'control-label'
  end

  def time_field
    text_field_tag  :inputTime,
                    nil,
                    class: "form-control input-small",
                    'data-error': "Vul een correcte tijd in.",
                    required: ""
  end

  def adults_tag
    label_tag :inputAdults, "Aantal volwassenen", class: 'control-label'
  end

  def adults_field
    number_field_tag  :inputAdults,
                      nil,
                      class: "form-control",
                      placeholder: "'2'",
                      in: 0...100,
                      'data-error': "Incorrect aantal volwassenen. Minimaal 0 volwassenen, maximaal 99.",
                      required: ""
      
  end

  def children_tag
    label_tag :inputChildren, "Aantal kinderen (tot 18 jaar)", class: 'control-label'
  end
  
  def children_field
    number_field_tag  :inputChildren,
                      nil,
                      class: "form-control",
                      placeholder: "'10'",
                      in: 5...100,
                      'data-error': "Incorrect aantal kinderen. Minimaal 5 kinderen, maximaal 99 kinderen.",
                      required: ""
  end

  def extra_tag
    label_tag :inputExtra, "Extra opmerkingen", class: 'control-label'
  end
  
  def extra_field
    text_field_tag  :inputExtra,
                    nil,
                    class: "form-control",
                    placeholder: "Extra opmerkingen (maximaal 150 tekens)",
                    pattern: '^.{0,150}$',
                    'data-error': "Maximaal 150 tekens"
  end
  
  def checkbox_tag
    @checkboxText = "Onderwatercamera voor 15 minuten: € 9,95 (neem een USB stick mee om de foto’s direct mee te nemen)"

    label_tag :checkboxCamera, @checkboxText
  end
  
  def checkbox_field
    check_box_tag :checkboxCamera, "1", false, class: "checkboxCamera"
  end
end