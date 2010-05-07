class AddVotedUserIdToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :voted_user_id, :integer, :null => false
  end

  def self.down
    remove_column :votes, :voted_user_id
  end
end
