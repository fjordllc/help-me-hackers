class Project < ActiveRecord::Base
  include Pacecar
  has_many :tasks
  validates_presence_of :name
  validates_uniqueness_of :name

  def solved_task_count
    task_count(true)
  end

  def unsolved_task_count
    task_count(false)
  end

  private
  def task_count(correct)
   t = Task.find(:first,
     :select     => 'COUNT(project_id) AS cnt',
     :conditions => ['project_id = ? AND id IN (SELECT task_id FROM comments WHERE correct = ?)', id, correct])
   t.present? ? t.cnt.to_i : 0
  end
end
