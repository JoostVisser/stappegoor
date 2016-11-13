# Preview all emails at http://localhost:3000/rails/mailers/form_mailer
class FormMailerPreview < ActionMailer::Preview
  def confirmation_mail_preview
    transactionHash = { "utf8"=>"✓", 
                        "authenticity_token"=>"4R4Bl8CkxIKrToO/0yBemlYibdZmVWVW8aRItv/eu923TiUiXX/E8wfzhgCxJEsoO9h8VZqqlCM1f6IGzpBKcA==", 
                        "packetType"=>"Film en Zwemfeestje met 3D brillen en onderwater camera.", 
                        "inputName"=>"Joost",
                        "inputBirthdayBoyName"=>"Hendrik",
                        "inputEmail"=>"Joost.visser1@gmail.com", 
                        "inputPhone"=>"+31640391707", 
                        "inputNrOfPersons"=>"3", 
                        "inputNrOfDiscounts"=>"2", 
                        "inputDate"=>"26-08-2016", 
                        "inputArrivalTime"=>"14:15", 
                        "inputTime"=>"17:45", 
                        "inputExtra"=>"Glutenvrij.", 
                        "checkboxCamera"=>"1"}
    transactionPrice = 99.7

    FormMailer.confirmation_email(transactionHash, transactionPrice)
  end

  def request_mail_preview
    transactionHash = { "utf8"=>"✓", 
                        "authenticity_token"=>"4R4Bl8CkxIKrToO/0yBemlYibdZmVWVW8aRItv/eu923TiUiXX/E8wfzhgCxJEsoO9h8VZqqlCM1f6IGzpBKcA==", 
                        "packetType"=>"Film en Zwemfeestje met 3D brillen en onderwater camera.", 
                        "inputName"=>"Joost",
                        "inputBirthdayBoyName"=>"Hendrik",
                        "inputEmail"=>"Joost.visser1@gmail.com", 
                        "inputPhone"=>"+31640391707", 
                        "inputNrOfPersons"=>"3", 
                        "inputNrOfDiscounts"=>"2", 
                        "inputDate"=>"26-08-2016", 
                        "inputArrivalTime"=>"14:15", 
                        "inputTime"=>"17:45", 
                        "inputExtra"=>"Glutenvrij.", 
                        "checkboxCamera"=>"1"}
    transactionPrice = 99.7

    FormMailer.request_email(transactionHash, transactionPrice)
  end

end