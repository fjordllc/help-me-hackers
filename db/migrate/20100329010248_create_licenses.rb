class CreateLicenses < ActiveRecord::Migration
  def self.up
    create_table :licenses do |t|
      t.string :name, :null => false
    end

    add_index :licenses, :name, :unique => true
  end

  def self.down
    drop_table :licenses
  end
end
