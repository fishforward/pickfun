require 'base64'
require 'rest_client'

class UpYun
    $Upyun_username = 'fish'
    $Upyun_password = 'fishgyuyi177'
    $Upyun_bucket = "forward"
    #@connection_options     = options[:connection_options] || {}
    $Host =  "http://v0.api.upyun.com"
    #$Upyun_bucket_domain = "forward.b0.upaiyun.com"
    $Http = RestClient::Resource.new("#{$Host}/#{$Upyun_bucket}", $Upyun_username , $Upyun_password )
        
    def upload(path,keyname)
      basic_str = "Basic #{Base64.encode64(''+$Upyun_username+':'+$Upyun_password)}"
      puts "str="+ basic_str

      puts "hhhttttpppp"+path +keyname
      #res= $Http.get({"Authorization" => basic_str})#,'Expect' => '', 'Mkdir' => 'true'       , 'content_type' => 'image/jpg'
      #f = $Http['/heap.jpg'].get({"Authorization" => basic_str})
      
      #aFile = File.new("1.jpg","w")
      #  aFile.puts f.to_s
      #aFile.close
      
      #res= $Http.put(File.read(path),{"Authorization" => basic_str,'Date'=> Time.new().to_s ,'Expect' => '', 'Mkdir' => 'true', 'content_type' => 'image/jpg'})#,'Expect' => '', 'Mkdir' => 'true'       , 'content_type' => 'image/jpg'
      #name = File.basename(path)
      fileData = File.read(path)
      #puts "123123123"+fileData.class.to_s + fileData.to_s
      res= $Http[PRE_PATH + keyname].put fileData,{"Authorization" => basic_str, 'Content-Length' => fileData.size(),'Expect' => '', 'Mkdir' => 'true'}
      
      puts "==============" + res.code.to_s
      puts "==============" + res.body
    end
    
end