require 'spec_helper'
require "ruby-debug"

describe GitHub do
  describe "code download" do
    before(:each) do
      @user = Factory(:user, :nick => 'gregory-m')
      
      stub_get("http://github.com/gregory-m/TestRepo/raw/master/MyTronBot.rb", "MyTronBot.rb")
      File.stub!(:makedirs).and_return(true)
      
      @stub_file = stub("file", :write => true)
      File.stub!(:open).and_yield(@stub_file)
    end
    
    it "should create directory for user's code" do
      File.should_receive(:makedirs).with("#{RAILS_ROOT}/public/code/gregory-m")
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
  end
end
