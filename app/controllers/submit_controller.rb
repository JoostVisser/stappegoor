class SubmitController < ApplicationController
  def kinderfeesten
    FormMailer.sample_email.deliver_now
    redirect_to "/"
  end

  def groupbooking
  end
end
