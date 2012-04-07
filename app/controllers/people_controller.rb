class PeopleController < ApplicationController
  
  def index
    @people = Person.mostly_active(params[:page])

    respond_to do |format|
      format.html
    end
  end
  
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @person = Person.new

    respond_to do |format|
      format.html
      format.xml  { render :xml =>  @person }
    end
  end

  def create
    cookies.delete :auth_token
    @person = Person.new(params[:person])
    respond_to do |format|
      @person.email_verified = false
      ##@person.identity_url = session[:verified_identity_url]
      @person.save
      puts @person.inspect
      puts @person.errors.inspect
      if @person.errors.empty?
        puts "==========123123123"
          self.current_person = @person
          flash[:notice] = "Thanks for signing up!"
          format.html { redirect_to(home_url) }
      else
        puts "--------"
        @body = "register single-col"
        format.html { render :partial => "shared/personal_details.html.erb", 
          :object => @person }
      end
    end
  rescue ActiveRecord::StatementInvalid
    # Handle duplicate email addresses gracefully by redirecting.
    redirect_to home_url
  rescue ActionController::InvalidAuthenticityToken
    # Experience has shown that the vast majority of these are bots
    # trying to spam the system, so catch & log the exception.
    warning = "ActionController::InvalidAuthenticityToken: #{params.inspect}"
    logger.warn warning
    redirect_to home_url
  end

  def edit
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html
    end
  end
  
  private

    def correct_user_required
      redirect_to home_url unless Person.find(params[:id]) == current_person
    end
    
end
