class User < ActiveRecord::Base
  is_gravtastic!

  def before_update
    if game_stats_changed?
      self.score = (self.wins + 0.5 * self.draws) / self.games_played
    end
  end
  
  def validate_on_create
    validate_url
  end
  
  def code_path
    "public/code/#{nick}"
  end
  
  
  private
  def get_nick_and_repo_name_from_url
    repo_url
  end
  
  def validate_url
    if repo_url =~ /^git:\/\/github.com\/([A-Za-z0-9-]+)\/([A-Za-z0-9-]+).git$/
      self.nick  = $1
      self.repo_name = $2
      if User.find_by_nick self.nick
        errors.add(:repo_url, "Пользователь с таким ником уже зарегестрирован")
      end
    else
      errors.add(:repo_url, "Неверный URL")
    end
  end
  
  def game_stats_changed?
    self.wins_changed? || self.losses_changed? || self.draws_changed? || self.games_played_changed?
  end
  
  def email
    'kossnocorp@gmail.com'
  end
end
