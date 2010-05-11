class AddAnswerToHack < ActiveRecord::Migration
  def self.up
    add_column :hacks, :answer, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :hacks, :answer
  end
end
