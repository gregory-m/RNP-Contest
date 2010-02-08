class UsersController < ApplicationController
  
  protect_from_forgery :except => [:update]
  
  def new
  end
  
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
      else
        format.html { render :action => "new" }     
      end
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.active?
        format.html # show.html.erb
      else
        format.html { render :action => "not_active" }
      end
    end
  end
  
  def update
    user_nick, user_email = get_user_nick_and_email_from_json(params[:payload])
    
    @user = User.find_by_nick user_nick
    
    if @user
      GitHub.new(@user).download_code
      upadate_user_email(@user, user_email) if @user.email.blank?
    end
    
    render :text => "OK"
  end
  
  def index
    @users = User.all(:order => 'users.score DESC')   
  end

  private
  def get_user_nick_and_email_from_json(json)
    push = JSON.parse(json)
    [ push["repository"]["owner"]["name"], push["repository"]["owner"]["email"] ]
  end
  
  def upadate_user_email(user, email)
    @user.email = email
    @user.save  
  end

end
