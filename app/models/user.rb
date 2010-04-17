class User < TwitterAuth::GenericUser
  belongs_to :language
  belongs_to :state
  has_many :problems
  has_many :answers
end
