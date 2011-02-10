class User < TwitterAuth::GenericUser
  belongs_to :language
  belongs_to :editor
  belongs_to :state
  has_many :tasks
  has_many :comments

  named_scope :count_by_language,
    :select => 'COUNT(users.id) AS cnt, MAX(languages.name) as name',
    :joins  => [:language],
    :group  => 'language_id',
    :order  => 'cnt DESC'

  named_scope :count_by_editor,
    :select => 'COUNT(users.id) AS cnt, MAX(editors.name) as name',
    :joins  => [:editor],
    :group  => 'editor_id',
    :order  => 'cnt DESC'

  named_scope :count_by_state,
    :select => 'COUNT(users.id) AS cnt, MAX(states.name) as name',
    :joins  => [:state],
    :group  => 'state_id',
    :order  => 'cnt DESC'

  def total_prize
    t = Task.find(:first,
      :select => 'SUM(bounty) AS total',
      :joins => [:comments],
      :conditions => ['comments.correct = ? AND comments.user_id = ?', true, id])
    t ? t.total.to_i : 0
  end

  def total_payment
    t = Task.find(:first,
      :select => 'SUM(bounty) AS total',
      :joins => [:comments],
      :conditions => ['comments.correct = ? AND tasks.user_id = ?', true, id])
    t ? t.total.to_i : 0
  end

  def vote_count
    Vote.count(:conditions => ['user_id = ?', self.id])
  end

  def voted_count
    Vote.count(:conditions => ['voted_user_id = ?', self.id])
  end
end
