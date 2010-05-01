class User < TwitterAuth::GenericUser
  belongs_to :language
  belongs_to :state
  has_many :problems
  has_many :hacks

  def prize
    p = Hack.find(:first,
              :select => 'sum(problems.bounty)',
              :joins => [:user, :problem],
              :conditions => ['hacks.correct = ? AND users.id = ?', true, id],
              :group => 'problems.id')
    p.present? ? p.first : 0
  end

  def vote
    Vote.count(:conditions => ['user_id = ?', self.id])
  end
end
