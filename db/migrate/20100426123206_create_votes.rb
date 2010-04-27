class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.boolean :vote, :null => false, :default => true
      t.integer :voteable_id, :null => false
      t.string :voteable_type, :null => false
      t.belongs_to :user

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
