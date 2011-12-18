require 'util/upyun'

class PicFile
  
  def initialize(pic)
    @picc = pic
  end
  
  def upload
    extname =File.extname(@picc.image_url)
    @picc.keyname=@picc.keyname + @picc.id.to_s + extname
    @picc.save
    
    UpYun.new().upload(@picc.image_url,@picc.keyname)
    
    File.delete(@picc.image_url)
    Dir.delete(File.dirname(@picc.image_url))
  end
  
end