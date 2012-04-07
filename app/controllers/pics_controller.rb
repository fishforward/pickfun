require "util/time_utils"
require "file/pic_file"

class PicsController < ApplicationController
  # GET /pics
  # GET /pics.xml
  def index
    
    subjectId = params[:subjectId]
    puts subjectId
    
    if(subjectId)
      subject = Subject.find(subjectId)
      if(subject)
        @pics = Pic.find_all_by_subject(subjectId)
      end
    else
      @pics = Pic.all
    end
    
    # 菜单标签配置
    @Pics_current = true;
    @SubjectId = subjectId
    puts @pics.inspect
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pics }
    end
  end

  # GET /pics/1
  # GET /pics/1.xml
  def show
    @pic = Pic.find(params[:id])
    @pic.setTags(@pic.id)
    
    # 菜单标签配置
    @Pics_current = true;

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pic  }#| @tags
    end
  end

  # GET /pics/new
  # GET /pics/new.xml
  def new
    @pic = Pic.new
    @default_tags = ''
    
    # 菜单标签配置
    @Upload_current = true;

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pic }
    end
  end

  # GET /pics/1/edit
  def edit
    @pic = Pic.find(params[:id])
  end

  # POST /pics
  # POST /pics.xml
  def create
    
    @pic = Pic.new(params[:pic])
    
    ## keyname前缀
    ## TODO 抽出来
    @pic.keyname =  Time.now.to_i.to_s + "_"
    
    ## TODO 也抽
    @pic.scores = 100
    @pic.wins = 0
    @pic.losses = 0
    @pic.source = 'local'
    
    respond_to do |format|
      if @pic.save
        
        extname =File.extname(@pic.image_url)
        @pic.keyname=@pic.keyname + @pic.id.to_s + extname
        @pic.original_pic = FILE_PATH_PRE + @pic.keyname
        @pic.bmiddle_pic = FILE_PATH_PRE + @pic.keyname + BIG_PIC
        @pic.thumbnail_pic = FILE_PATH_PRE + @pic.keyname + MIDDLE_PIC
        
        @pic.save
        
        UpYun.new().upload(@pic.image_url,@pic.keyname)
        
        File.delete(@pic.image_url)
        Dir.delete(File.dirname(@pic.image_url))
        
        ## tags处理
        if @pic.tmptags
          tmp = @pic.tmptags.gsub(';',' ') #英文的分号
          #tmp = tmp.gsub('；',' ') #中文的分号
          tmp = tmp.gsub(',',' ')  #英文的逗号
          #tmp = tmp.gsub('，',' ')  #中文的逗号
          
          tmp.split.each do |n|
            tag = Tag.find_by_name(n)
            if tag == nil
              tag =Tag.new(
                :name => n
              )
              tag.save
            end
            
            picTag = PicTag.new(
              :pic_id => @pic.id,
              :tag_id => tag.id
            )
            picTag.save
          end
        end
        
        format.html { redirect_to(@pic) }
        format.xml  { render :xml => @pic, :status => :created, :location => @pic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pic.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  # PUT /pics/1
  # PUT /pics/1.xml
  def update
    @pic = Pic.find(params[:id])

    respond_to do |format|
      if @pic.update_attributes(params[:pic])
        flash[:notice] = 'Pic was successfully updated.'
        format.html { redirect_to(@pic) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pics/1
  # DELETE /pics/1.xml
  def destroy
    @pic = Pic.find(params[:id])
    @pic.destroy

    respond_to do |format|
      format.html { redirect_to(pics_url) }
      format.xml  { head :ok }
    end
  end
end
