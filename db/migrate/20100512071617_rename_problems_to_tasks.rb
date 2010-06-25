class RenameProblemsToTasks < ActiveRecord::Migration
  def self.up
    rename_table :problems, :tasks
    rename_column :comments, :problem_id, :task_id

    execute "UPDATE taggings SET taggable_type = 'Task' WHERE taggable_type = 'Problem'"
    execute "UPDATE votes SET voteable_type = 'Task' WHERE voteable_type = 'Problem'"
  end

  def self.down
    rename_table :tasks, :problems
    rename_column :comments, :task_id, :problem_id

    execute "UPDATE taggings SET taggable_type = 'Problem' WHERE taggable_type = 'Task'"
    execute "UPDATE votes SET voteable_type = 'Problem' WHERE voteable_type = 'Task'"
  end
end
