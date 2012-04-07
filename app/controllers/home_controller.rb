class HomeController < ApplicationController

#  def index
#    @title = "Home"
#    
#    respond_to do |format|
#      format.html { redirect_to(:controller => 'picks', :action =>'cc')};
#    end
#  end
  
  ## 定制型首页，不直接跳转到picks/new
  ## 为了保证首页地址的简单
  def index
    
    @l_pics = Pic.find(:all, :order => "RANDOM() LIMIT 1");
    l_id = @l_pics[0].id;
    @r_pics = Pic.find(:all, :conditions =>["id <> ?", l_id], :order => "RANDOM() LIMIT 1");
    
    @l_pic = @l_pics[0];
    @r_pic = @r_pics[0];
    
    # left pic 设置tag
    @l_pic.setTags(@l_pic.id)
    # right pic 设置tag
    @r_pic.setTags(@r_pic.id)
    
    # subject
    @subjectId = '0'
    
    #进度条获取
    @pickPercentage = Pic.count(:all, :conditions =>["wins > 0 or losses > 0"] );
    @picSum = Pic.count(:all);
    
    # 菜单标签配置
    @Home_current = true;
    @SubjectId = @subjectId
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @l_pic | @r_pic | @pickPercentage | @picSum | @Home_current | @subjectId | @SubjectId }
    end
    
  end
  
end 