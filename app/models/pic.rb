class Pic < ActiveRecord::Base
  
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
              
              
   ## 设置默认值 
   #def initialize
     #:scores => 100   ## 初始100
     #:wins => 0       ## pk win次数
     #:losses => 0     ## pk loss次数
     #:subject => "default"   ## 暂时默认的主题类型
   #end
   
   
   def self.search(page)  
    paginate :per_page => 10, :page => page,  
             :order => 'scores desc'  
   end 
              
end
