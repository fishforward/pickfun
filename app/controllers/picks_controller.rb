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
    @l_pic = Pic.find(id[0])
    @r_pic = Pic.find(id[1])

    #进度条获取
    @pickPercentage = Pic.count(:all, :conditions =>["wins > 0 or losses > 0"] );
    @picSum = Pic.count(:all);
    
    # 菜单标签配置
    @Home_current = true;

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @l_pic | @r_pic | @pickPercentage | @picSum | @Home_current}
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
    pickId = @l_pic.id.to_s + "_" + @r_pic.id.to_s

    respond_to do |format|
      format.html { redirect_to :action => "show", :id => pickId}
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
    @pick.user = 'mySelf';
    @pick.ip = request.remote_ip;
    
    @pick.win_pic_id = @win_pic_id;
    @pick.loss_pic_id = @lose_pic_id;
         
     pp = Pic.new;
     pp.pk(@win_pic_id, @lose_pic_id);
     #winPic.pk(@lose_pic_id);
     
     puts @win_pic_id
      
     respond_to do |format|
       if @pick.save
          
            flash[:notice] = 'Have Fun Pick Pic!  winner: ' + @win_pic_id + ",losser:" + @lose_pic_id ;
            format.html { redirect_to(:action =>'new')};
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
