class UploadController < ApplicationController
  def index
     render :file => 'app/views/upload/uploadfile.rhtml'
  end
  def uploadFile
    path = DataFile.save(params[:upload])
    image = Image.new
    image.path = path
    image.title = "Erik äger."
    image.author = "Erik"
    image.slide_id = 1
    image.save
    render :text => "File has been uploaded successfully"
  end
end
