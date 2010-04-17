class CreateKinds < ActiveRecord::Migration
  def self.up
    create_table :kinds do |t|
      t.string :name, :null => false
      t.boolean :premium, :default => false, :null => false
    end

    add_index :kinds, :name, :unique => true
  end

  def self.down
    drop_table :kinds
  end
end
