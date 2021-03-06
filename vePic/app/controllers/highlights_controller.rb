class HighlightsController < ApplicationController
  # GET /highlights
  # GET /highlights.xml
  def index
    @highlights = Highlight.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @highlights }
    end
  end

  # GET /highlights/1
  # GET /highlights/1.xml
  def show
    @highlight = Highlight.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @highlight }
    end
  end

  # GET /highlights/new
  # GET /highlights/new.xml
  def new
    @highlight = Highlight.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @highlight }
    end
  end

  # GET /highlights/1/edit
  def edit
    @highlight = Highlight.find(params[:id])
  end

  # POST /highlights
  # POST /highlights.xml
  def create
    @highlight = Highlight.new(params[:highlight])

    respond_to do |format|
      if @highlight.save
        flash[:notice] = 'Highlight was successfully created.'
        format.html { redirect_to(@highlight) }
        format.xml  { render :xml => @highlight, :status => :created, :location => @highlight }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @highlight.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /highlights/1
  # PUT /highlights/1.xml
  def update
    @highlight = Highlight.find(params[:id])

    respond_to do |format|
      if @highlight.update_attributes(params[:highlight])
        flash[:notice] = 'Highlight was successfully updated.'
        format.html { redirect_to(@highlight) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @highlight.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /highlights/1
  # DELETE /highlights/1.xml
  def destroy
    @highlight = Highlight.find(params[:id])
    @highlight.destroy

    respond_to do |format|
      format.html { redirect_to(highlights_url) }
      format.xml  { head :ok }
    end
  end
end
