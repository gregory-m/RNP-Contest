class AddRepoUrlToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :repo_url, :string
  end

  def self.down
    remove_column :users, :repo_url
  end
end
