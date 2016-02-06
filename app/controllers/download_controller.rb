class DownloadController < ApplicationController
  def doc
    send_file Rails.root.join('private', 'kinderfeest-formulier.doc'), type: "application/doc", x_sendfile: true
  end

  def pdf
    send_file Rails.root.join('private', 'kinderfeest-informatie.pdf'), type: "application/pdf", x_sendfile: true
  end
end
