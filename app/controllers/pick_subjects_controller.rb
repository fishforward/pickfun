class PickSubjectsController < ApplicationController

  # GET /pick_subjects/1
  # GET /pick_subjects/1.xml
  def show
    subjectId = params[:id]
    
    if(subjectId == '0')
      respond_to do |format|
          format.html { redirect_to :controller=> "picks", :action => "new",
                                    :last_l_pic_id => params[:last_l_pic_id], :last_r_pic_id => params[:last_r_pic_id] }
        end
    else

    @l_pics = Pic.find_all_by_subject(subjectId, :order => "RANDOM() LIMIT 1");
    if(@l_pics && @l_pics.size > 0)
        l_id = @l_pics[0].id;
        @r_pics = Pic.find_all_by_subject(subjectId, :conditions =>["id <> ?", l_id], :order => "RANDOM() LIMIT 1");
        
        @l_pic = @l_pics[0];
        @r_pic = @r_pics[0];
        
        # 菜单标签配置
        @Home_current = true;
        @Home_secode = subjectId
        pickId = @l_pic.id.to_s + "_" + @r_pic.id.to_s
        pickId = pickId + "_" + subjectId
        
        respond_to do |format|
          format.html { redirect_to :controller=> "picks", :action => "show", :id => pickId,
                                    :last_l_pic_id => params[:last_l_pic_id], :last_r_pic_id => params[:last_r_pic_id] }
        end
     end
     end
  end

end
