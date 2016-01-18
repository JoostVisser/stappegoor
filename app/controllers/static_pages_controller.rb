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
end
