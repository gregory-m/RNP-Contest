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
  
  describe "update" do
    before(:each) do
      User.stub!(:find_by_nick).and_return(@user = stub_model(User))
      
      @git_hub_stub = stub("GitHub stub", :download_code => true)
      GitHub.stub!(:new).and_return(@git_hub_stub)
    end
  
    it "should find user by nick" do
      User.should_receive(:find_by_nick).with("gregory-m")
      do_requset
    end
    
    it "should download users code" do
      GitHub.should_receive(:new).with(@user)
      @git_hub_stub.should_receive(:download_code)
      do_requset
    end
    
    it "should not download code for not existing user" do
      User.stub!(:find_by_nick).and_return(nil)
      GitHub.should_not_receive(:new).with(@user)
      @git_hub_stub.should_not_receive(:download_code)
      do_requset
    end
    
    def do_requset
      post :update, "payload"=>"{\"commits\":[{\"url\":\"http://github.com/gregory-m/RNP-Contest-Test-Bot/commit/bd798657cb67d89593c9f73e66f98cae03d8a928\",\"message\":\"Post-Receive hook test\",\"added\":[],\"removed\":[],\"modified\":[\"MyTronBot.rb\"],\"author\":{\"email\":\"man.gregory@gmail.com\",\"name\":\"Gregory Man\"},\"timestamp\":\"2010-02-08T09:01:12-08:00\",\"id\":\"bd798657cb67d89593c9f73e66f98cae03d8a928\"}],\"repository\":{\"description\":\"\",\"open_issues\":0,\"watchers\":1,\"url\":\"http://github.com/gregory-m/RNP-Contest-Test-Bot\",\"fork\":false,\"forks\":0,\"private\":false,\"homepage\":\"\",\"owner\":{\"email\":\"gregory@kaddabra.co.il\",\"name\":\"gregory-m\"},\"name\":\"RNP-Contest-Test-Bot\"},\"ref\":\"refs/heads/master\",\"before\":\"84827cbfc5eee0944d81c93047bb0d052a41d6e0\",\"after\":\"bd798657cb67d89593c9f73e66f98cae03d8a928\"}"
    end
  end
end
