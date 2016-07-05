class SubmitController < ApplicationController
  def kinderfeesten
    FormMailer.sample_email
    redirect_to home_url
  end

  def groupbooking
  end
end
