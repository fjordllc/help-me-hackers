class User < TwitterAuth::GenericUser
  belongs_to :language
  belongs_to :state
  has_many :problems
  has_many :answers

  def prize
    p = ActiveRecord::Base.connection.select_values(
      "select sum(problems.bounty) as prize
       from answers 
         join users on answers.user_id = users.id 
         join problems on answers.problem_id = problems.id 
       where answers.correct = true and users.id = #{self.id} 
       group by problems.id limit 1", :prize
    )
    p.empty? ? 0 : p.first.to_i
  end

  def vote
    Vote.count(:conditions => ['user_id = ?', self.id])
  end
end
