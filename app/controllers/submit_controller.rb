class SubmitController < ApplicationController
  def kinderfeesten
    transactionHash = params.except("utf8")
    # The price is calculated afterwards to avoid people messing with it.
    transactionPrice = calculateTransactionPrice transactionHash
    
    nrOfPersons = transactionHash["inputNrOfPersons"].to_f
    nrOfDiscounts = transactionHash["inputNrOfDiscounts"].to_f


    # If illegal transactionprice or less than 5 persons.
    if transactionPrice == 0 || (nrOfPersons + nrOfDiscounts < 5)
      redirect_to kinderfeest_failure_url
    else
      FormMailer.confirmation_email(transactionHash, transactionPrice).deliver_now
      FormMailer.request_email(transactionHash, transactionPrice).deliver_now
      redirect_to kinderfeest_success_url
    end
  end

  def groupbooking
  end

  # Helper functions
  def calculateTransactionPrice(transactionHash)
    transactionType = transactionHash["packetType"]
    nrOfPersons = transactionHash["inputNrOfPersons"].to_f
    nrOfDiscounts = transactionHash["inputNrOfDiscounts"].to_f
    if transactionType.include? "Standaard Zwemfeestje"
      costPerPerson = 9.95
    elsif transactionType.include? "Luxe Zwemfeestje"
      costPerPerson = 12.75
    elsif transactionType.include? "Film en Zwemfeestje"
      costPerPerson = 16.95
    else
      return 0
    end
    # Extra cost for optional 3D glasses
    costPerPerson += 1  if transactionType.include? "3D brillen"
    
    # Calculation of the cost.
    transactionPrice = costPerPerson * nrOfPersons
    transactionPrice += (costPerPerson - 4.20) * nrOfDiscounts

    # Optional under water camera.
    transactionPrice += 9.95 if transactionType.include? "onderwatercamera"
    
    return transactionPrice
  end

end
