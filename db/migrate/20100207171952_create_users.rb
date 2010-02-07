class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :nick
      t.string  :last_commit_sha
      t.integer :wins,         :default => 0
      t.integer :losses,       :default => 0
      t.integer :draws,        :default => 0
      t.integer :games_played, :default => 0
      t.float   :score,          :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
