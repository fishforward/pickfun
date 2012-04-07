class Pic < ActiveRecord::Base
  attr_accessor :tags
  #has_and_belongs_to_many :tags
  #attr_accessible :scores => 100, :wins => 0, :losses => 0, :subject => "default"
  
  ## 参数校验
  validates_presence_of :title, :message => "can't be blank."
  validates_presence_of :image_url, :message => "can't be blank."
  validates_length_of   :description, :maximum => 125, :message=>"description exceed the limit."

  validates_format_of :image_url,
        :with=>/^.*(.jpg|.JPG|.gif|.GIF|.png|.PNG)$/,
        :message => "GIF|JPG|PNG are supported."
  
  ## 临时文件服务器上传
  file_column :image_url, 
              :root_path =>  "public",
              :web_root => ""
  
  def self.insertByImport(pic)
    time = Time.new.strftime('%Y-%m-%d %H:%M:%S')
    
    sql = "insert into pics(keyname,subject,title,description,image_url,original_pic,bmiddle_pic,thumbnail_pic,scores,wins,losses,tmptags,source,created_at,updated_at) 
           values('#{pic.keyname}','#{pic.subject}','#{pic.title}','#{pic.description}','#{pic.image_url}','#{pic.original_pic}','#{pic.bmiddle_pic}','#{pic.thumbnail_pic}','#{pic.scores}','#{pic.wins}','#{pic.losses}','#{pic.tmptags}','#{pic.source}','#{time}','#{time}')"
           
    ActiveRecord::Base.connection.execute(sql);
  end
              
  # 根据pic获取tags
  def setTags(picId)
    
    picTags = PicTag.find_all_by_pic_id(picId)
    #puts picTags.size
    if(picTags)
      tagIds = Array.new
      picTags.each do |pt|
        tagIds << pt.tag_id
      end
      if tagIds.size > 0
        tmp_tags = Tag.find(tagIds, :order => "name desc")
      end 
    end
    @tags = tmp_tags
   end            
              
   ## 设置默认值 
   #def initialize
     #:scores => 100   ## 初始100
     #:wins => 0       ## pk win次数
     #:losses => 0     ## pk loss次数
     #:subject => "default"   ## 暂时默认的主题类型
   #end
   
   
   def self.search(page,subject)  
    paginate :conditions =>["subject = ?", subject],
             :per_page => 10, :page => page, 
             :order => 'scores desc'  
   end 
   
   
   def pk(winPicId, losePicId)
    winPic = Pic.find(winPicId);
    losePic = Pic.find(losePicId);
    
    record(winPic, losePic);
#    puts winPic;
#    puts losePic;
  end

  def record(winPic, losePic)
    #winPic.scores = winPic.scores + 1;
    winExpectation = getExpectation(winPic.scores, losePic.scores, 1);
    #puts 'winExpectation:'+winExpectation.to_s;
    winPic_scores = getNewScores(winPic.scores, winExpectation, 1);
    #puts 'win_s:' + winPic_scores.to_s;
   
 
    #losePic.scores = losePic.scores - 1;
    loseExpectation = getExpectation(winPic.scores, losePic.scores, -1);
    #puts 'loseExpectation:' + loseExpectation.to_s;
    losePic_scores = getNewScores(losePic.scores, loseExpectation, 0);
    #puts 'lose_s:' + losePic_scores.to_s;
    
    winPic.scores = winPic_scores
    winPic.wins = winPic.wins + 1;
    if !winPic.save
      #puts 'winPic.save exception'
      #throw Exception("update ex");
    end
    
    losePic.scores = losePic_scores;
    losePic.losses = losePic.losses + 1; 
    if !losePic.save
      #puts 'losePic.save exception'
      #throw Exception("update ex");
    end
  end
  

  ## 计分 - 获取期望值 
  def getExpectation(winScores,loseScores,flag)
   return 1 / (1 + 10 ** ((loseScores - winScores) * flag / 400.to_f));
  end
  
  ## 计分 - 获取本次PK分值
  def getNewScores(oldScores,expectation,sa )
    return oldScores + 16.to_f * ( sa - expectation);
  end
  
  #获取picked的pic数据
  def self.getPickProgress
    
    #pick百分比
     Pic.count(:all, :conditions =>["wins > 0 or losses > 0"] );
    
  end
  
  #获取pic总数
  def self.allPicSum
    Pic.count(:all);
  end
              
end
