class Task < ActiveRecord::Base
  include Pacecar
  acts_as_taggable
  belongs_to :user
  belongs_to :language
  belongs_to :license
  belongs_to :project
  has_many :comments
  has_many :votes, :as => :voteable, :dependent => :destroy

  validates_presence_of :title,
                        :description,
                        :language,
                        :license,
                        :user
  validates_length_of :title, :within => 4..255
  validates_length_of :description, :minimum => 20

  named_scope :unsolved,
    :conditions => ['tasks.id NOT IN (SELECT task_id FROM comments WHERE correct = ?)', true],
    :order      => 'tasks.id DESC'

  named_scope :nonfree,
    :conditions => 'bounty > 0',
    :order      => 'bounty DESC'

  named_scope :count_by_language,
    :select => 'COUNT(tasks.id) AS cnt, MAX(languages.name) as name',
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

  def unsolved?
    !solved?
  end

  def correct_comment
    Comment.find(:first,
      :conditions => ['task_id = ? AND correct = ?', id, true])
  end

  def solver
    (c = correct_comment) ? c.user : nil
  end
end
