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

  def name_tag
    label_tag :inputName, "Naam"
  end

  def name_field
    text_field_tag  :inputName,
                    nil,
                    class: "form-control",
                    placeholder: "Naam",
                    pattern: '^.{0,50}$',
                    'data-error': "Maximaal 50 tekens.",
                    required: ""
  end

  def birthday_boy_name_tag
    label_tag :inputBirthdayBoyName, "Naam jarige"
  end

  def birthday_boy_name_field
    text_field_tag  :inputBirthdayBoyName,
                    nil,
                    class: "form-control",
                    placeholder: "Naam jarige",
                    pattern: '^.{0,50}$',
                    'data-error': "Maximaal 50 tekens.",
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

  def phone_nr_tag
    label_tag :inputPhone, "Telefoonnummer", class: 'control-label'
  end

  def phone_nr_field
    telephone_field_tag :inputPhone,
                        nil,
                        class: 'form-control',
                        placeholder: "Telefoonnummer",
                        pattern: '(^\+[0-9]{2}|^\+[0-9]{2}\(0\)|^\(\+[0-9]{2}\)\(0\)|^00[0-9]{2}|^0)([0-9]{9}$|[0-9\-\s]{10}$)',
                        'data-error': "Telefoonnummer is incorrect",
                        required: ""
  end

  def time_tag
    label_tag :inputTime, "Voorkeur etenstijd", class: 'control-label'
  end

  def time_field
    text_field_tag  :inputTime,
                    nil,
                    class: "form-control input-small",
                    'data-error': "Vul een correcte tijd in.",
                    required: ""
  end

  def arrival_time_tag
    label_tag :inputArrivalTime, "Aankomsttijd", class: 'control-label'
  end

  def arrival_time_field
    text_field_tag  :inputArrivalTime,
                    nil,
                    class: "form-control input-small",
                    'data-error': "Vul een correcte tijd in.",
                    required: ""
  end

  def nr_of_persons_tag
    label_tag :inputNrOfPersons, "Aantal personen", class: 'control-label'
  end

  def nr_of_persons_field
    number_field_tag  :inputNrOfPersons,
                      nil,
                      class: "form-control",
                      placeholder: "'2'",
                      in: 0...100,
                      'data-error': "Incorrect aantal personen. Minimaal 0, maximaal 99.",
                      required: ""
      
  end

  def nr_of_discounts_tag
    label_tag :inputNrOfDiscounts, "Aantal personen met korting", class: 'control-label'
  end
  
  def nr_of_discounts_field
    number_field_tag  :inputNrOfDiscounts,
                      nil,
                      class: "form-control",
                      placeholder: "'10'",
                      in: 0...100,
                      'data-error': "Incorrect aantal personen met korting. Minimaal 0, maximaal 99.",
                      required: ""
  end

  def extra_tag
    label_tag :inputExtra, "Extra opmerkingen", class: 'control-label'
  end
  
  def extra_field
    text_field_tag  :inputExtra,
                    nil,
                    class: "form-control",
                    placeholder: "Extra opmerkingen (maximaal 250 tekens)",
                    pattern: '^.{0,250}$',
                    'data-error': "Maximaal 250 tekens."
  end
  
  def checkbox_tag
    @checkboxText = "Onderwatercamera voor 15 minuten: € 9,95 (neem een USB stick mee om de foto’s direct mee te nemen)"

    label_tag :checkboxCamera, @checkboxText
  end
  
  def checkbox_field
    check_box_tag :checkboxCamera, "1", false, class: "checkboxCamera"
  end
end