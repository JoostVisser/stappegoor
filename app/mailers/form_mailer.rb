class FormMailer < ApplicationMailer
# Sample parameters:   
# $Parameters: {"utf8"=>"✓", 
              # "authenticity_token"=>"4R4Bl8CkxIKrToO/0yBemlYibdZmVWVW8aRItv/eu923TiUiXX/E8wfzhgCxJEsoO9h8VZqqlCM1f6IGzpBKcA==", 
              # "packetType"=>"Film en Zwemfeestje met 3D brillen en onderwater camera.", 
              # "inputEmail"=>"Joost.visser1@gmail.com", 
              # "inputDate"=>"26-08-2016", 
              # "inputTime"=>"12:45", 
              # "inputAdults"=>"3", 
              # "inputChildren"=>"2", 
              # "inputExtra"=>"Glutenvrij.", 
              # "checkboxCamera"=>"1"}

# Need something to calculate the price with.

  def get_transaction_data (transactionHash, transactionPrice)
    @business_email = 'joost.visser1@gmail.com'

    @transactionId = transactionHash["authenticity_token"][1..8]
    @transactionType = transactionHash["packetType"]
    @transactionPrice = transactionPrice

    @transactionDate = transactionHash["inputDate"]
    @transactionTime = transactionHash["inputTime"]

    @nrOfAdults = transactionHash["inputAdults"]
    @nrOfChildren = transactionHash["inputChildren"]

    @customer_email = transactionHash["inputEmail"]
    @extraComments = transactionHash["inputExtra"]
  end

  def confirmation_email (transactionHash, transactionPrice)
    get_transaction_data transactionHash, transactionPrice
    email = mail from: @business_email, to: @customer_email, subject: 'Stappegoor - Bevestiging zwemfeest'
  end

  def request_email (transactionHash, transactionPrice)
    get_transaction_data transactionHash, transactionPrice
    request_email_subject = 'Aanvraag Kinderfeest ' + @transactionId
    email = mail from: @customer_email, to: @business_email, subject: request_email_subject
  end

end
