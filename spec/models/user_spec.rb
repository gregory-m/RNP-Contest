require 'spec_helper'

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
  end
end
