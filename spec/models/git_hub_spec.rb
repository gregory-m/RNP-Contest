require 'spec_helper'
require "ruby-debug"

describe GitHub do
  describe "code download" do
    before(:each) do
      @user = Factory(:user, :repo_url => "git://github.com/gregory-m/TestRepo.git")
      
      stub_get("http://github.com/gregory-m/TestRepo/raw/master/MyTronBot.rb", "MyTronBot.rb")
      FileUtils.stub!(:mkdir_p).and_return(true)
      
      @stub_file = stub("file", :write => true)
      File.stub!(:open).and_yield(@stub_file)
    end
    
    it "should create directory for user's code" do
      FileUtils.should_receive(:mkdir_p).with("#{RAILS_ROOT}/public/code/gregory-m")
      GitHub.new(@user).download_code
    end
    
    it "should open file" do
      File.should_receive(:open).with("#{RAILS_ROOT}/public/code/gregory-m/MyTronBot.rb", "w")
      GitHub.new(@user).download_code
    end
    
    it "should write code to file" do
      @stub_file.should_receive(:write).with(fixture_file("MyTronBotSafe.rb"))
      GitHub.new(@user).download_code
    end
    
    it "should raise exeption if code not found" do
      FakeWeb.register_uri(:get, "http://github.com/gregory-m/TestRepo/raw/master/MyTronBot.rb", 
                                 :body => "Nothing to be found 'round here",
                                 :status => ["404", "Not Found"])
      lambda { 
        GitHub.new(@user).download_code
      }.should raise_error
    end
    
    it "should make user active" do
      User.destroy_all
      @user = Factory(:user, :repo_url => "git://github.com/gregory-m/TestRepo.git", :active => false)
    
      lambda { 
        GitHub.new(@user).download_code
      }.should change{@user.reload.active?}  
    end
  end
end
