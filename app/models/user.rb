class User < ActiveRecord::Base
  
  def before_update
    if game_stats_changed?
      self.score = (self.wins + 0.5 * self.draws) / self.games_played
    end
  end
  
  def code_path
    "public/code/#{nick}"
  end
  
  
  private
  def game_stats_changed?
    self.wins_changed? || self.losses_changed? || self.draws_changed? || self.games_played_changed?
  end
end
