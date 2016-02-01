class StaticPagesController < ApplicationController

  def home
  end

  def kinderfeesten
    add_breadcrumb "home", root_path
  end


  def contact
    add_breadcrumb "home", root_path
  end
end
