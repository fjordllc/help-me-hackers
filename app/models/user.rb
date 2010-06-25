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
    t = Bounty.find(:first,
      :select     => 'SUM(bounties.amount) AS total_bounty',
      :conditions => ['bounties.id IN (SELECT task_id FROM comments WHERE correct = ? AND user_id = ?)', true, id])
    t ? t.total_bounty.to_i : 0
  end

  def total_payment
    t = Bounty.find(:first,
      :select     => 'SUM(amount) AS total_bounty',
      :conditions => ['pay = ? AND user_id = ?', true, id])
    t ? t.total_bounty.to_i : 0
  end

  def vote_count
    Vote.count(:conditions => ['user_id = ?', self.id])
  end

  def voted_count
    Vote.count(:conditions => ['voted_user_id = ?', self.id])
  end
end
