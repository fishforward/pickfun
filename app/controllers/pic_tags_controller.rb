class PicTagsController < ApplicationController
  # GET /pic_tags
  # GET /pic_tags.xml
  def index
    @pic_tags = PicTag.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pic_tags }
    end
  end

  # GET /pic_tags/1
  # GET /pic_tags/1.xml
  def show
    @pic_tag = PicTag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pic_tag }
    end
  end

  # GET /pic_tags/new
  # GET /pic_tags/new.xml
  def new
    @pic_tag = PicTag.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pic_tag }
    end
  end

  # GET /pic_tags/1/edit
  def edit
    @pic_tag = PicTag.find(params[:id])
  end

  # POST /pic_tags
  # POST /pic_tags.xml
  def create
    @pic_tag = PicTag.new(params[:pic_tag])

    respond_to do |format|
      if @pic_tag.save
        flash[:notice] = 'PicTag was successfully created.'
        format.html { redirect_to(@pic_tag) }
        format.xml  { render :xml => @pic_tag, :status => :created, :location => @pic_tag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pic_tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pic_tags/1
  # PUT /pic_tags/1.xml
  def update
    @pic_tag = PicTag.find(params[:id])

    respond_to do |format|
      if @pic_tag.update_attributes(params[:pic_tag])
        flash[:notice] = 'PicTag was successfully updated.'
        format.html { redirect_to(@pic_tag) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pic_tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pic_tags/1
  # DELETE /pic_tags/1.xml
  def destroy
    @pic_tag = PicTag.find(params[:id])
    @pic_tag.destroy

    respond_to do |format|
      format.html { redirect_to(pic_tags_url) }
      format.xml  { head :ok }
    end
  end
end
