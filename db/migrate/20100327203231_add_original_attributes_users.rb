class AddOriginalAttributesUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :email, :string
    add_column :users, :state_id, :integer
    add_column :users, :language_id, :integer
    add_column :users, :company, :string
    add_column :users, :github_account, :string
    add_column :users, :ssh_public_key, :text
    add_column :users, :reputation, :integer, :default => 0, :null => false
    add_column :users, :kind, :string

    add_index :users, :login, :unique => true
    add_index :users, :email, :unique => true
  end

  def self.down
    remove_column :users, :email
    remove_column :users, :state
    remove_column :users, :language
    remove_column :users, :company
    remove_column :users, :github_account
    remove_column :users, :ssh_public_key
    remove_column :users, :reputation
    remove_column :users, :type

    remove_index :users, :login
    remove_index :users, :email
  end
end
