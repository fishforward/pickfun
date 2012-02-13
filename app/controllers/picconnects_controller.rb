require 'weibo'
class PicconnectsController < ApplicationController
  
  Weibo::Config.api_key = "4022165667"
  Weibo::Config.api_secret = "8271b9156aec7bb1bf0017a3fd88c5a6"
  
  # GET /picconnects
  # GET /picconnects.xml
  def index
    
    oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)
    oauth.authorize_from_access(session[:atoken], session[:asecret])
    
    i = 1
    pic_count = 0
    @picconnects = []
    while @picconnects.size < 20 && i < 3
      @tmp = Weibo::Base.new(oauth).user_timeline({:feature => 1, :trim_user => 1, :count => 20, :page => i })
      
      @tmp.each do |t|
        if t.original_pic
          @picconnects << t
        end
      end
      i = i+1
    end  
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @picconnects }
    end
  end

  # POST /picconnects
  # POST /picconnects.xml
  def create
    
    puts params.inspect
    pic_chooses = params[:pic_choose]
    pic_chooses.each do |pid|
      original_pic_v = 'original_pic' + pid
      original_pic = params[original_pic_v]
      puts original_pic
    end
    
    respond_to do |format|
      format.html { redirect_to :action => "picconnects" }
    end
  end
  
end
