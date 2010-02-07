require 'spec_helper'
require "ruby-debug"

describe Game do
  describe "Creation and validations" do
    it "should create game" do
      lambda {
        Factory(:game)
      }.should change(Game, :count)
    end
    
    describe "palyer one win" do
      it "should update user1 ratings" do
        @user = Factory(:user)
        @game = Factory(:game, :player1 => @user )
        @game.game_result = 1      
        lambda {
          @game.save
        }.should change{@user.wins}.by(1)
      end
    
      it "should update user2 ratings" do
        @user = Factory(:user)
        @game = Factory(:game, :player2 => @user )
        @game.game_result = 1      
        lambda {
          @game.save
        }.should change{@user.losses}.by(1)
      end      
    end

    describe "palyer two win" do
      it "should update user1 ratings" do
        @user = Factory(:user)
        @game = Factory(:game, :player1 => @user )
        @game.game_result = 2      
        lambda {
          @game.save
        }.should change{@user.losses}.by(1)
      end
    
      it "should update user2 ratings" do
        @user = Factory(:user)
        @game = Factory(:game, :player2 => @user )
        @game.game_result = 2      
        lambda {
          @game.save
        }.should change{@user.wins}.by(1)
      end      
    end
    
    describe "on draw" do
      it "should update user1 ratings" do
        @user = Factory(:user)
        @game = Factory(:game, :player1 => @user )
        @game.game_result = -1
        lambda {
          @game.save
        }.should change{@user.draws}.by(1)
      end
    
      it "should update user2 ratings" do
        @user = Factory(:user)
        @game = Factory(:game, :player2 => @user )
        @game.game_result = -1
        lambda {
          @game.save
        }.should change{@user.draws}.by(1)
      end      
    end
  end
end
