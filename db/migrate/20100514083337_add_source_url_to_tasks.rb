class AddSourceUrlToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :source_url, :text
  end

  def self.down
    remove_column :tasks, :source_url
  end
end
