class AddBitbucketAccountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :bitbucket_account, :string
  end

  def self.down
    remove_column :users, :bitbucket_account
  end
end
