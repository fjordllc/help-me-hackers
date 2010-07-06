class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string :name, :null => false
      t.belongs_to :country
    end

    add_index :states, :name
  end

  def self.down
    drop_table :states
  end
end
