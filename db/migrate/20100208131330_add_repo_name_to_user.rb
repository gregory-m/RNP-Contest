class AddRepoNameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :repo_name, :string
  end

  def self.down
    remove_column :users, :repo_name
  end
end
