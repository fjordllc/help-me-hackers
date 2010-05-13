class Task < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  belongs_to :language
  belongs_to :license
  belongs_to :category
  has_many :comments
  has_many :votes, :as => :voteable, :dependent => :destroy

  validates_presence_of :title,
                        :description,
                        :category,
                        :language,
                        :license,
                        :user,
                        :bounty
  validates_length_of :title, :within => 4..255
  validates_length_of :description, :minimum => 30

  named_scope :unsolved,
    :select => 'tasks.*, sum(comments.correct) as correct_sum',
    :joins  => 'LEFT JOIN comments ON tasks.id = comments.task_id',
    :group  => 'tasks.id HAVING correct_sum < 1 OR correct_sum IS NULL'

  named_scope :paid,
    :conditions => ['bounty > ?', 0],
    :order      => 'bounty DESC'

  named_scope :by_category,
    :select => 'COUNT(tasks.id) AS cnt, categories.name',
    :joins  => [:category],
    :group  => 'category_id',
    :order  => 'cnt DESC'

  named_scope :by_language,
    :select => 'COUNT(tasks.id) AS cnt, languages.name',
    :joins  => [:language],
    :group  => 'language_id',
    :order  => 'cnt DESC'

  def self.increment_view_by_id(id)
    task = self.find(id)
    task.view += 1
    task.save
  end

  def solved?
    !!correct_comment
  end

  def correct_comment
    Comment.find(:first,
      :conditions => ['task_id = ? AND correct = ?', id, true])
  end

  def solver
    correct_comment.user
  end
end
