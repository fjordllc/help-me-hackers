class CreateBounties < ActiveRecord::Migration
  def self.up
    create_table :bounties do |t|
      t.belongs_to :user, :null => false
      t.belongs_to :task, :null => false
      t.integer :amount, :null => false
      t.boolean :pay, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :bounties
  end
end
