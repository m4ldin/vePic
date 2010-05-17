class ThumbController < ApplicationController
  
  require 'rubygems'
  require 'gd2'
  include GD2 

  def index

    path = "public/data/"    # default image library directory
    widthx = 500          # default width of generated image
    heightx = 500         # default height of generated image
    
    if params[:w] then widthx = params[:w].to_i
    end

    if params[:h] then heightx = params[:h].to_i
    end    
           
    filepath = path + params[:specs].join("/")    # Path to file
    
    format = filepath.split(".").last             # Format - extension
    
    filename = params[:specs].last.split(".").first # just file name without extension

    #require 'digest/md5'
    digest = Digest::MD5.hexdigest( filepath )      # md5 hash
    cachefile = digest + "-" + widthx.to_s + heightx.to_s + "." + format


    picfile = filepath
    cachedpicfile = path + "image_cache/" + cachefile
   
    if File.exists?(cachedpicfile) && (File.stat( cachedpicfile ).mtime.to_i > File.stat( picfile ).mtime.to_i)
      picsource = cachedpicfile
      cache = true
    elsif File.exists? picfile 
      picsource = picfile
    end
   

    if cache == true    # Read from Cache
      @pic = File.new(picsource).read
    else                # Import an image
      i = Image.import(picsource)
     
      if i.size[0] > i.size[1]  # Horizontal proportion. width > height.
        if i.size[0] < widthx then width = i.size[0]     # preffer smaller image width
        else width = widthx
        end
       
        height = width * i.size[1] / i.size[0]
        
      else                      # Vertical proportions
        if i.size[1] < heightx then height = i.size[1]
        else height = heightx
        end
        
        width = i.size[0] /(i.size[1] / height) 
      end
     
      i.resize! width, height
     
      if format == "gif" then @pic = i.gif
      elsif format == "png" then @pic = i.png
      else @pic = i.jpeg 80
      end
     
      i.export(path + 'image_cache/' + cachefile ) # export cache file
    end
    
    
    cgi = CGI.new
  	cgi.out("type"=>"image/jpeg") { @pic }
  	render :nothing => true
    
    respond_to do |format|
      format.html { send_data @pic, :filename => File.basename(picsource), :type => 'image/jpeg', :disposition => 'inline' }
    end
  	
  end  
end