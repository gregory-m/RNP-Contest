require 'spec_helper'

describe CodeRunner do
  describe "perform" do
    before(:each) do
      @test_runner = CodeRunner.new
    end
    
    it "should run bot" do
      @test_runner.should_receive(:'`').with("java -jar #{RAILS_ROOT}/engine/Tron.jar #{RAILS_ROOT}/maps/empty-room.txt 'ruby #{RAILS_ROOT}/tmp/bots/MyTronBot.rb' 'ruby #{RAILS_ROOT}/tmp/bots/MyTronBot.rb' 0 1")
      @test_runner.perform
    end
  end
end