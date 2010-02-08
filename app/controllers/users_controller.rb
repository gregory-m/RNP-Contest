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
      format.html # show.html.erb
    end
  end
  
  def update
    user_nick = get_user_nick_from_json(params[:payload])
    @user = User.find_by_nick user_nick
    
    if @user
      GitHub.new(@user).download_code
    end
    
    render :text => "OK"
  end
  
  private
  def get_user_nick_from_json(json)
    push = JSON.parse(json)
    push["repository"]["owner"]["name"]
  end

end
