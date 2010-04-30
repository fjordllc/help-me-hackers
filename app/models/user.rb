class User < TwitterAuth::GenericUser
  belongs_to :language
  belongs_to :state
  has_many :problems
  has_many :hacks

  def prize
    p = ActiveRecord::Base.connection.select_values(
      "select sum(problems.bounty) as prize
       from hacks 
         join users on hacks.user_id = users.id 
         join problems on hacks.problem_id = problems.id 
       where hacks.correct = true and users.id = #{self.id} 
       group by problems.id limit 1", :prize
    )
    p.empty? ? 0 : p.first.to_i
  end

  def vote
    Vote.count(:conditions => ['user_id = ?', self.id])
  end
end
