class CreateProblems < ActiveRecord::Migration
  def self.up
    create_table :problems do |t|
      t.string :title, :null => false
      t.text :description, :null => false
      t.belongs_to :user, :null => false
      t.belongs_to :category, :null => false
      t.belongs_to :language, :null => false
      t.belongs_to :license, :null => false
      t.integer :bounty, :default => 0, :null => false
      t.integer :view, :default => 0, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :problems
  end
end
