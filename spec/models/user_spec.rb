require 'spec_helper'
require "ruby-debug"

describe User do
  describe "Creation and validations" do
    it "should create user" do
      lambda {
        Factory(:user)  
      }.should change(User, :count) 
    end
    
    it "should calculate score after update" do
      @user = Factory(:user)
      lambda {
        @user.update_attributes(:wins => 422, :losses => 3, :draws => 8, :games_played => 433)
      }.should change{@user.reload.score}.from(0).to(0.983833718244804)
    end
    
    it "should create user from GitHub URL" do
      @user = User.create(:repo_url => "git://github.com/gregory-m/RNP-Contest-Bot.git")
      
    end
  end
  
  
  describe "code_path" do
    it "should return relative path to user's code" do
      @user = Factory(:user)
      @user.code_path.should == "public/code/#{@user.nick}"
    end
  end
end
