class Game < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :player1, :class_name => "User"
  belongs_to :player2, :class_name => "User"
  
  
  def after_update
    if game_result_changed?
      case game_result
      when -1
        player1.draws += 1
        player2.draws += 1  
      when 1
        player1.wins += 1
        player2.losses += 1
      when 2
        player2.wins += 1
        player1.losses += 1      
      end
      player1.games_played += 1
      player2.games_played += 1
      
      player1.save
      player2.save
    end
  end
end
