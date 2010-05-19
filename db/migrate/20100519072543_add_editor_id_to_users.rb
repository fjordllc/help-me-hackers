class AddEditorIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :editor_id, :integer
  end

  def self.down
    remove_column :users, :editor_id
  end
end
