class MoveBountyToBounties < ActiveRecord::Migration
  def self.up
    Task.all.each do |task|
      if task.bounty > 0
        Bounty.create!(:amount  => task.bounty,
                       :task_id => task.id,
                       :user_id => task.user.id)
      end
    end

    remove_column :tasks, :bounty
  end

  def self.down
    add_column :tasks, :bounty
  end
end
