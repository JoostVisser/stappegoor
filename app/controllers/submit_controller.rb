class SubmitController < ApplicationController
  def kinderfeesten
    FormMailer.sample_email
    redirect_to "/"
  end

  def groupbooking
  end
end
