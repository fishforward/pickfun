require 'weibo'
class ConnectWeibosController < ApplicationController
  Weibo::Config.api_key = "4022165667"
  Weibo::Config.api_secret = "8271b9156aec7bb1bf0017a3fd88c5a6"
  
  def connect
    oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)
    request_token = oauth.consumer.get_request_token
    session[:rtoken], session[:rsecret] = request_token.token, request_token.secret
    
    respond_to do |format|
      format.html { redirect_to "#{request_token.authorize_url}&oauth_callback=http://#{request.env["HTTP_HOST"]}/connect_weibos/callback" }
    end
  end
  
  def callback
    oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)
    oauth.authorize_from_request(session[:rtoken], session[:rsecret], params[:oauth_verifier])
    session[:rtoken], session[:rsecret] = nil, nil
    session[:atoken], session[:asecret] = oauth.access_token.token, oauth.access_token.secret
    
    oauth.authorize_from_access(session[:atoken], session[:asecret])
    ouser = Weibo::Base.new(oauth).verify_credentials
    session[:aid], session[:aname] = ouser.id, ouser.name
    
    respond_to do |format|
      format.html { redirect_to :controller => 'picconnects' }
    end
  end
  
  def logout
    session[:atoken], session[:asecret] = nil, nil
    session[:aid], session[:aname] = nil, nil
    respond_to do |format|
      format.html { redirect_to :controller => 'picks', :action => 'new' }
    end
  end
  
end
