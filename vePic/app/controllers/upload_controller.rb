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
    
    image.save

    #render :text => "File has been uploaded successfully"
    redirect_to "/slides/new?image=" << image.id.to_s
  end
end
