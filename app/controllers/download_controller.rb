class DownloadController < ApplicationController
  def doc
    send_file Rails.root.join('private', 'kinderfeest-formulier.doc'), :type=>"application/doc", :x_sendfile=>true
  end
end
