class User < TwitterAuth::GenericUser
  belongs_to :language
  belongs_to :editor
  belongs_to :state
  has_many :tasks
  has_many :comments

  named_scope :count_by_language,
    :select => 'COUNT(users.id) AS cnt, languages.name',
    :joins  => [:language],
    :group  => 'language_id',
    :order  => 'cnt DESC'

  named_scope :count_by_editor,
    :select => 'COUNT(users.id) AS cnt, editors.name',
    :joins  => [:editor],
    :group  => 'editor_id',
    :order  => 'cnt DESC'

  named_scope :count_by_state,
    :select => 'COUNT(users.id) AS cnt, states.name',
    :joins  => [:state],
    :group  => 'state_id',
    :order  => 'cnt DESC'

  def total_prize
   t = Task.find(:first,
     :select     => 'SUM(bounty) AS total_bounty',
     :conditions => ['id IN (SELECT task_id FROM comments WHERE correct = ? AND user_id = ?)', true, id])
   t ? t.total_bounty.to_i : 0
  end

  def total_payment
   t = Task.find(:first,
     :select     => 'SUM(bounty) AS total_bounty',
     :conditions => ['id IN (SELECT task_id FROM comments WHERE correct = ?) AND user_id = ?', true, id])
   t ? t.total_bounty.to_i : 0
  end

  def vote_count
    Vote.count(:conditions => ['user_id = ?', self.id])
  end

  def voted_count
    Vote.count(:conditions => ['voted_user_id = ?', self.id])
  end
end
