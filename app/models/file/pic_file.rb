require 'util/upyun'

class PicFile
  
  def initialize(pic)
    @picc = pic
  end
  
  def upload
    extname =File.extname(@picc.original_pic)
    @picc.keyname=@picc.keyname + @picc.id.to_s + extname
    @picc.save
    
    UpYun.new().upload(@picc.original_pic,@picc.keyname)
    
    File.delete(@picc.original_pic)
    Dir.delete(File.dirname(@picc.original_pic))
  end
  
end