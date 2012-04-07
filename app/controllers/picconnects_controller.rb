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
    
    nums = params[:num]
    pic_chooses = params[:pic_choose]
    original_pics = params[:original_pic]
    bmiddle_pics = params[:bmiddle_pic]
    thumbnail_pics = params[:thumbnail_pic]
    descriptions = params[:description]
    
    subjects = params[:pic_s]
    
    pic_chooses.each_with_index do |pid,i|
      num = nums[i].to_i
            
      newpic = Pic.new
      newpic.keyname = pic_chooses[i]  ##存的是weibo的id号
      puts "===="+subjects[num].to_s
      newpic.subject = (subjects[num]!=nil && subjects[num]!='') ? subjects[num] : 'default'
      newpic.title = 'default'
      newpic.description = descriptions[i]
      newpic.original_pic = original_pics[i]
      newpic.bmiddle_pic = bmiddle_pics[i]
      newpic.thumbnail_pic = thumbnail_pics[i]
      newpic.scores = 100
      newpic.wins = 0
      newpic.losses = 0
      newpic.source = 'weibo'
      
      Pic.insertByImport(newpic)
    end
    
    respond_to do |format|
      format.html { redirect_to :controller => "pics" }
    end
  end
  
end
