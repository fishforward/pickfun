# encoding: utf-8
class PicksController < ApplicationController
  # GET /picks
  # GET /picks.xml
  def index
    @picks = Pick.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @picks }
    end
  end
  
  # GET /picks/1
  # GET /picks/1.xml
  def show
    pickId = params[:id]
    id = pickId.split('_')
    
    last_l_pic_id = params[:last_l_pic_id]
    last_r_pic_id = params[:last_r_pic_id]
    puts '======' + last_l_pic_id.to_s
    if last_l_pic_id
      @last_l_pic = Pic.find(last_l_pic_id)
    end
    if last_r_pic_id
      @last_r_pic = Pic.find(last_r_pic_id)
    end
    
    # left pic
    @l_pic = Pic.find(id[0])
    @l_pic.setTags(@l_pic.id)
    # right pic
    @r_pic = Pic.find(id[1])
    @r_pic.setTags(@r_pic.id)
    
    # subject
    @subjectId = id[2]==nil ? '0' : id[2] 
    
    #进度条获取
    @pickPercentage = Pic.count(:all, :conditions =>["wins > 0 or losses > 0"] );
    @picSum = Pic.count(:all);
    
    # 菜单标签配置
    @Home_current = true;
    @SubjectId = @subjectId

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @l_pic | @r_pic | @last_l_pic | @last_r_pic | @pickPercentage | @picSum | @Home_current | @subjectId | @SubjectId }
    end
  end

  # GET /picks/new
  # GET /picks/new.xml
  def new
    @l_pics = Pic.find(:all, :order => "RANDOM() LIMIT 1");
    l_id = @l_pics[0].id;
    @r_pics = Pic.find(:all, :conditions =>["id <> ?", l_id], :order => "RANDOM() LIMIT 1");
    
    @l_pic = @l_pics[0];
    @r_pic = @r_pics[0];
    
    # 菜单标签配置
    @Home_current = true;

    pickId = @l_pic.id.to_s + "_" + @r_pic.id.to_s + '_'

    respond_to do |format|
      format.html { redirect_to :action => "show", :id => pickId, :method => :post,
                                :last_l_pic_id => params[:last_l_pic_id], :last_r_pic_id => params[:last_r_pic_id] }
    end
  end

  # GET /picks/1/edit
  def edit
    @pick = Pick.find(params[:id])
  end

  # POST /picks
  # POST /picks.xml
  def create
    @win_pic_id = params[:l_pic_id];
    @lose_pic_id = params[:r_pic_id];
    
    @pick = Pick.new
    @pick.user = 'mySelf'
    @pick.ip = request.remote_ip
    @pick.subject = params[:subjectId]
    #puts params[:subjectId]+'-------'
    
    @pick.win_pic_id = @win_pic_id
    @pick.loss_pic_id = @lose_pic_id
         
     pp = Pic.new
     pp.pk(@win_pic_id, @lose_pic_id)
     
     respond_to do |format|
       if @pick.save
          
            flash[:notice] = 'Have Fun Pick Pic!  winner: ' + @win_pic_id + ",losser:" + @lose_pic_id ;
            format.html { redirect_to(:controller => "pick_subjects",:action =>"show", :id => @pick.subject, 
                                      :last_l_pic_id => params[:last_l_pic_id], :last_r_pic_id => params[:last_r_pic_id] )};
           # format.xml  { render :xml => @picks }
        else
            format.html { redirect_to(:action =>'new')};
            format.xml  { render :xml => @pic.errors, :status => :unprocessable_entity }
        end
     end
  end

  # PUT /picks/1
  # PUT /picks/1.xml
  def update
    @pick = Pick.find(params[:id])

    respond_to do |format|
      if @pick.update_attributes(params[:pick])
        flash[:notice] = 'Pick was successfully updated.'
        format.html { redirect_to(@pick) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pick.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /picks/1
  # DELETE /picks/1.xml
  def destroy
    @pick = Pick.find(params[:id])
    @pick.destroy

    respond_to do |format|
      format.html { redirect_to(picks_url) }
      format.xml  { head :ok }
    end
  end
end
