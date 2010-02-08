class User < ActiveRecord::Base
  is_gravtastic!

  def before_update
    if game_stats_changed?
      self.score = (self.wins + 0.5 * self.draws) / self.games_played
      self.score = self.score * 0.2 if self.games_played < 20
    end
  end
  
  def validate_on_create
    validate_url
  end
  
  def code_path
    "public/code/#{nick}"
  end
  
  def code
    file = File.open "#{RAILS_ROOT}/#{code_path}/MyTronBot.rb", 'r'
    file.read
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
      errors.add(:repo_url, "Сами не знаем почему, но ваш URL нам не нравиться")
    end
  end
  
  def game_stats_changed?
    self.wins_changed? || self.losses_changed? || self.draws_changed? || self.games_played_changed?
  end
end
