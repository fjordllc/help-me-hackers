class Project < ActiveRecord::Base
  include Pacecar
  has_many :tasks
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :description

  def solved_task_count
    t = Task.find(:first,
      :select     => 'COUNT(project_id) AS cnt',
      :conditions => ['project_id = ? AND id IN (SELECT task_id FROM comments WHERE correct = ?)', id, true])
    t.present? ? t.cnt.to_i : 0
  end

  def unsolved_task_count
    t = Task.find(:first,
      :select     => 'COUNT(project_id) AS cnt',
      :conditions => ['project_id = ? AND id NOT IN (SELECT task_id FROM comments WHERE correct = ?)', id, true])
    t.present? ? t.cnt.to_i : 0
  end
end
