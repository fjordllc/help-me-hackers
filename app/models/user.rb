class User < TwitterAuth::GenericUser
  belongs_to :language
  belongs_to :state
  has_many :tasks
  has_many :comments

  def total_prize
    p = Comment.find(:first,
      :select => 'sum(tasks.bounty) as prize',
      :joins => [:user, :task],
      :conditions => ['comments.correct = ? AND users.id = ?', true, id],
      :group => 'tasks.id')
    p.present? ? p.prize.to_i : 0
  end

  def total_payment
    p = Task.find(:first,
      :select => 'sum(tasks.bounty) as payment',
      :joins => [:comments],
      :conditions => ['comments.correct = ? AND tasks.user_id = ?', true, id],
      :group => 'tasks.id')
    p.present? ? p.payment.to_i : 0
  end

  def vote_count
    Vote.count(:conditions => ['user_id = ?', self.id])
  end

  def voted_count
    Vote.count(:conditions => ['voted_user_id = ?', self.id])
  end
end
