require 'net/ftp'

class FormsController < ApplicationController
  def new
  end

  def upload
    uploaded_content = params[:content]
    file_name = params[:file_name]
    if file_name == ''
      file_name = uploaded_content.original_filename
    end
    File.open(Rails.root.join('public', 'uploads', file_name), 'wb') do |file|
      ftpClient = Net::FTP.new('ftpupload.net')
      ftpClient.login(user = ENV['FTP_USERNAME'], passwd = ENV['FTP_PASSWORD'])
      ftpClient.passive = true
      ftpClient.chdir('/htdocs/uploaded_through_ftp_uploader_app')
      ftpClient.putbinaryfile(file)
      format_message_and_redirect(ftpClient.last_response)
      ftpClient.quit()
    end
  end

  def format_message_and_redirect(ftp_response)
    if ftp_response.include? '226'
      flash[:success] = ftp_response
    else
      flash[:error] = ftp_response
    end
    redirect_to '/'
  end
end
