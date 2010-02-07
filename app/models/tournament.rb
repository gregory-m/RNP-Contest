class Tournament < ActiveRecord::Base
  has_many :games
  
  def validate
    errors.add_to_base("Only one user in system") if User.count <= 1
  end
  
  def before_create
    @users = User.find(:all)
    @combuned_users = combine(@users)
    create_games(@combuned_users)
  end


  private  
  
  def combine(n, k=2)
    return [[]] if n.nil? || n.empty? && k == 0
    return [] if n.nil? || n.empty? && k > 0
    return [[]] if n.size > 0 && k == 0
    c2 = n.clone
    c2.pop
    new_element = n.clone.pop
    combine(c2, k) + append_all(combine(c2, k-1), new_element)
  end

  def append_all(lists, element)
    lists.map { |l| l << element }
  end
  
  def create_games(combuned_users)
    combuned_users.each do |game_users|
      self.games << Game.new(:player1 => game_users[0], :player2 => game_users[1], :tournament => self)
    end
  end
end
