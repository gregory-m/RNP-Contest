require 'spec_helper'

describe CodeRunner do
  describe "perform" do
    before(:each) do
      3.times do
        Factory(:user)
      end
      @users = User.all
      Tournament.create!
      @test_runner = CodeRunner.new
      
    end
    
    it "should run bots" do
      @test_runner.stub!(:'`').and_return("1Player One Wins!\n")
      @test_runner.should_receive(:'`').with("java -jar #{RAILS_ROOT}/engine/Tron.jar #{RAILS_ROOT}/maps/empty-room.txt 'ruby #{player_code_full_path(@users[0])}' 'ruby #{player_code_full_path(@users[1])}' 0 1")
      @test_runner.should_receive(:'`').with("java -jar #{RAILS_ROOT}/engine/Tron.jar #{RAILS_ROOT}/maps/empty-room.txt 'ruby #{player_code_full_path(@users[0])}' 'ruby #{player_code_full_path(@users[2])}' 0 1")
      @test_runner.should_receive(:'`').with("java -jar #{RAILS_ROOT}/engine/Tron.jar #{RAILS_ROOT}/maps/empty-room.txt 'ruby #{player_code_full_path(@users[1])}' 'ruby #{player_code_full_path(@users[2])}' 0 1")
      @test_runner.perform
    end
    
    describe "games update" do
      it "set 1 to game_result if player 1 win" do
        @test_runner.stub!(:'`').and_return("1Player One Wins!\n")
        @test_runner.perform
        Game.last.game_result.should == 1
      end
      
      it "set 2 to game_result if player 2 win" do
        @test_runner.stub!(:'`').and_return("2Player Two Wins!\n")
        @test_runner.perform
        Game.last.game_result.should == 2
      end
      
      it "set -1 to game_result on draw" do
        @test_runner.stub!(:'`').and_return("-1Both players crashed. Draw!\n")
        @test_runner.perform
        Game.last.game_result.should == -1
      end
      
    end
    private
    def player_code_full_path(user)
      "#{RAILS_ROOT + "/" + user.code_path}/MyTronBot.rb"
    end
  end
end