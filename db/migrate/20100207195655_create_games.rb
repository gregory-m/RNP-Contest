class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.belongs_to :player1
      t.belongs_to :player2
      t.belongs_to :tournament
      
      t.integer :game_result
      
      
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
