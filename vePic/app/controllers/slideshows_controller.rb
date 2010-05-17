require 'json'

class SlideshowsController < ApplicationController

  def serializeSlideshow(slideshow)
    slides = []
    slideshow.sequence.split(",").each do |sequence|
      slide = Slide.find(sequence.to_i)
      highlights = []
      image = {'path' => File.basename(slide.image.path), 'title' => slide.image.title, 'author' => slide.image.author}
      slide.highlights.each do |highlight|
        highlights << {'body' => highlight.body, 'x' => highlight.x, 'y' => highlight.y, 'w' => highlight.w, 'h' => highlight.h}
      end
      slides << {'title' => slide.title, 'body' => slide.body, 'image' => image, 'highlights' => highlights}
    end
    {'slides' => slides}.to_json
  end
  
  # GET /slideshows
  # GET /slideshows.xml
  def index
    @slideshows = Slideshow.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @slideshows }
    end
  end

  # GET /slideshows/1
  # GET /slideshows/1.xml
  def show
    @slideshow = Slideshow.find(params[:id])
    @slideshow_text = serializeSlideshow(@slideshow)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @slideshow }
    end
  end

  # GET /slideshows/new
  # GET /slideshows/new.xml
  def new
    @slideshow = Slideshow.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @slideshow }
    end
  end

  # GET /slideshows/1/edit
  def edit
    @slideshow = Slideshow.find(params[:id])
  end

  # POST /slideshows
  # POST /slideshows.xml
  def create
    @slideshow = Slideshow.new(params[:slideshow])
    @slideshow.slides << Slide.find(params[:slide_pick])
    @slideshow.sequence = params[:slide_pick].to_s

    respond_to do |format|
      if @slideshow.save
        flash[:notice] = 'Slideshow was successfully created.'
        format.html { redirect_to(edit_slideshow_path(@slideshow)) }
        format.xml  { render :xml => @slideshow, :status => :created, :location => @slideshow }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @slideshow.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /slideshows/1
  # PUT /slideshows/1.xml
  def update
    @slideshow = Slideshow.find(params[:id])
    seq = @slideshow.sequence.split(",")
    if params[:slide_pick]
      @slideshow.slides << Slide.find(params[:slide_pick])
      seq.push params[:slide_pick].to_s
      @slideshow.sequence = seq.join(",")
    end
    if params[:slide_remove]
      @slideshow.slides.delete(Slide.find(params[:slide_remove]))
      seq.delete(params[:slide_remove].to_s)
      @slideshow.sequence = seq.join(",")
    end
    if params[:slide_up]
      index = seq.index(params[:slide_up].to_s)
      if index > 0
        seq.delete(params[:slide_up].to_s)
        seq.insert(index - 1, params[:slide_up].to_s)
        @slideshow.sequence = seq.join(",")
      end
    end
    if params[:slide_down]
      index = seq.index(params[:slide_down].to_s)
      if index < seq.length - 1
        seq.delete(params[:slide_down].to_s)
        seq.insert(index + 1, params[:slide_down].to_s)
        @slideshow.sequence = seq.join(",")
      end
    end

    respond_to do |format|
      if @slideshow.update_attributes(params[:slideshow])
        flash[:notice] = 'Slideshow was successfully updated.'
        format.html { redirect_to(edit_slideshow_path(@slideshow)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @slideshow.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /slideshows/1
  # DELETE /slideshows/1.xml
  def destroy
    @slideshow = Slideshow.find(params[:id])
    @slideshow.destroy

    respond_to do |format|
      format.html { redirect_to(slideshows_url) }
      format.xml  { head :ok }
    end
  end
end
