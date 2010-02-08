require 'spec_helper'

describe UsersController do

  #Delete these examples and add some real ones
  it "should use UsersController" do
    controller.should be_an_instance_of(UsersController)
  end


  describe "POST /users (create)" do
    before(:each) do
      @user = stub_model(User, :save => true)
      User.stub!(:new).and_return(@user)
    end
    
    describe "with right url" do
      it "should initate new user" do
        User.should_receive(:new).with("repo_url" => "git://github.com/gregory-m/RNP-Contest-Bot.git")
        do_request
      end
      
      it "should save user" do
        @user.should_receive(:save)
        do_request
      end
      
      it "should redirect to user" do
        do_request
        response.should redirect_to(user_url(@user))
      end
    end
    
    describe "with wring URL" do
      before(:each) do
        @user.stub!(:save).and_return(false)
      end
      
      it "should initate new user" do
        User.should_receive(:new).with("repo_url" => "git://github.com/gregory-m/RNP-Contest-Bot.git")
        do_request
      end
      
      it "should save user" do
        @user.should_receive(:save)
        do_request
      end
      
      it "should rerender new action" do
        do_request
        response.should render_template("new")
      end
    end
    
    def do_request
      post :create, :user => {:repo_url => "git://github.com/gregory-m/RNP-Contest-Bot.git"}
    end
  end

  describe "GET /users/new (new)" do
    it "should be successful" do
      response.should be_success
    end
    
    it "should render new action" do
      do_request
      response.should render_template("new")
    end
    
    def do_request
       get 'new'
    end
  end
  
  describe "GET /users/1 (show)" do
    before(:each) do
      User.stub(:find).and_return(@user = stub_model(User))
    end
    
    it "should find user" do
      User.should_receive(:find).with("1")
      do_request
    end
    
    it "should render show action" do
      do_request
      response.should render_template("show")
    end
    
    def do_request
      get :show, :id => 1
    end
  end
end
