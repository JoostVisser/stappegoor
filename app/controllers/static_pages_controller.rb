class StaticPagesController < ApplicationController

  def home
  end

  def kinderfeesten
    add_breadcrumb "home", root_path
    add_breadcrumb "kinderfeesten", kinderfeesten_path
  end


  def contact
    add_breadcrumb "home", root_path
    add_breadcrumb "contact", contact_path
  end

  def kinderfeest_success
    add_breadcrumb "home", root_path
    add_breadcrumb "kinderfeesten", kinderfeesten_path
    add_breadcrumb "gelukt", kinderfeest_success_path
  end

  def kinderfeest_failure
    add_breadcrumb "home", root_path
    add_breadcrumb "kinderfeesten", kinderfeesten_path
    add_breadcrumb "mislukt", kinderfeest_failure_path
  end
end
