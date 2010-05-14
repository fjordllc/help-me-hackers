class RemoveAnswerToComments < ActiveRecord::Migration
  def self.up
    remove_column :comments, :answer
  end

  def self.down
    add_column :comments, :answer, :boolean
  end
end
