class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :name, :null => false
      t.string :kind, :null => false
    end

    add_index :languages, :name, :unique => true
  end

  def self.down
    drop_table :languages
  end
end
