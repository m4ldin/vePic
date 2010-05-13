class UploadController < ApplicationController
  def index
     render :file => 'app/views/upload/uploadfile.rhtml'
  end
  def uploadFile
    slide = Slide.new
    slide.body = "Per äger"
    slide.title = "Pew"
    slide.save
    path = DataFile.save(params[:upload])
    image = Image.new
    image.path = path
    image.title = "Erik äger."
    image.author = "Erik"
    image.slide_id = 1
    image.save

    # render :text => "File has been uploaded successfully"
    render :text => params.to_s
  end
end
