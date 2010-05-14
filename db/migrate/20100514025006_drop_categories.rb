class DropCategories < ActiveRecord::Migration
  def self.up
    drop_table :categories
    remove_column :tasks, :category_id
  end

  def self.down
    create_table :categories do |t|
      t.string :name, :null => false
    end

    add_column :tasks, :category_id, :integer
    add_index :categories, :name, :unique => true
  end
end
