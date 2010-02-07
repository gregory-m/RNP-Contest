Factory.define :game do |g|
  g.player1 { |player1| player1.association(:user) }
  g.player2 { |player2| player2.association(:user) }
end