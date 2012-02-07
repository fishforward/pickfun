class AboutController < ApplicationController
  
  # GET /about/message
  def message
    @About_current = true
    @About_secode = '1'
  end
  
  # GET /about/me
  def me
    @About_current = true
    @About_secode = '2'
  end

end
