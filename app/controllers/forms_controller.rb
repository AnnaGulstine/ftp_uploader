require 'net/ftp'

class FormsController < ApplicationController
  def index
  end

  def new
  end

  def upload
    uploaded_content = params[:content]
    File.open(Rails.root.join('public', 'uploads', uploaded_content.original_filename), 'wb') do |file|
      file.write(uploaded_content.read)
      ftp = Net::FTP.new('ftpupload.net')
      ftp.login(user = ENV['FTP_USERNAME'], passwd = ENV['FTP_PASSWORD'])
      ftp.passive = true
      ftp.chdir('/htdocs')
      ftp.putbinaryfile(file)
      ftp.quit()
    end
  end
end
