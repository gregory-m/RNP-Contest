require 'spec_helper'
require "ruby-debug"

describe Tournament do
  describe "creation and validations" do
    before(:each) do
      4.times do
        Factory(:user)
      end
    end
    
    it "should not create tornament for one user" do
      User.delete_all
      @tournament = Tournament.create
      @tournament.should have(1).error_on(:base)
    end
    
    it "should create turnament" do
      lambda { 
        Tournament.create
      }.should change(Tournament, :count)
      
    end
    
    it "should create games for all users" do
      @turnament = Tournament.create!
      @turnament.games.length.should == 6
    end
    
    it "should not create games for not active users" do
      @not_active_user = Factory(:user, :active => false)
      @turnament = Tournament.create!

      @players = []
      @players << @turnament.games.map(&:player1)
      @players << @turnament.games.map(&:player2)
      
      @players.flatten!
      @players.should_not include(@not_active_user)
    end
    
    
  end

end
