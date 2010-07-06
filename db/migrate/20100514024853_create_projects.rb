class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name, :null => false, :limit => 255
      t.text :description
      t.text :website_url
      t.text :repository_path

      t.timestamps
    end

    add_index :projects, :name, :unique => true
  end

  def self.down
    drop_table :projects
  end
end
