class Problem < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  belongs_to :language
  belongs_to :license
  belongs_to :category
  has_many :hacks
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
    :select => 'problems.*, sum(hacks.correct) as correct_sum',
    :joins  => 'LEFT JOIN hacks ON problems.id = hacks.problem_id',
    :group  => 'problems.id HAVING correct_sum < 1 OR correct_sum IS NULL'

  named_scope :paid,
    :conditions => ['bounty > ?', 0],
    :order      => 'bounty DESC'

  def self.increment_view_by_id(id)
    problem = self.find(id)
    problem.view += 1
    problem.save
  end

  def solved?
    !!correct_hack
  end

  def correct_hack
    Hack.find(:first,
      :conditions => ['problem_id = ? AND correct = ?', id, true])
  end

  def solver
    correct_hack.user
  end
end
