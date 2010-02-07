class CodeRunner
  def perform
    Game.find_each(:conditions => "game_result IS NULL") {|game| 
      result_string = run_game(game)
      upadate_game_result(result_string, game)
    }
  end
  
  private
  def run_game(game)
    %x[java -jar #{RAILS_ROOT}/engine/Tron.jar #{RAILS_ROOT}/maps/empty-room.txt 'ruby #{RAILS_ROOT + "/" + game.player1.code_path}/MyTronBot.rb' 'ruby #{RAILS_ROOT + "/" + game.player2.code_path}/MyTronBot.rb' 0 1]
  end
  
  def upadate_game_result(result_string, game)
    result = result_string.split("\n").last.to_i
    game.game_result = result
    game.save
  end
end
