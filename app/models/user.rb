class User < TwitterAuth::GenericUser
  belongs_to :language
  belongs_to :state
  has_many :problems
  has_many :hacks

  def total_prize
    p = Hack.find(:first,
      :select => 'sum(problems.bounty) as prize',
      :joins => [:user, :problem],
      :conditions => ['hacks.correct = ? AND users.id = ?', true, id],
      :group => 'problems.id')
    p.present? ? p.prize.to_i : 0
  end

  def total_payment
    p = Problem.find(:first,
      :select => 'sum(problems.bounty) as payment',
      :joins => [:hacks],
      :conditions => ['hacks.correct = ? AND problems.user_id = ?', true, id],
      :group => 'problems.id')
    p.present? ? p.payment.to_i : 0
  end

  def vote_count
    Vote.count(:conditions => ['user_id = ?', self.id])
  end

  def voted_count
    Vote.count(:conditions => ['voted_user_id = ?', self.id])
  end
end
