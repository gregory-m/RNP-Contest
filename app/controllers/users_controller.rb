class UsersController < ApplicationController
  
  protect_from_forgery :except => [:update]
  
  def new
  end
  
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      unless @user.save
        format.html { render :action => "new" }     
      else
        format.html { }
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
  
  def index
    @users = User.all(:order => 'users.score DESC')   
  end

  private
  def get_user_nick_from_json(json)
    push = JSON.parse(json)
    push["repository"]["owner"]["name"]
  end

end
