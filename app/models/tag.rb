class Tag < ActiveRecord::Base
  validates_format_of :name, :with => /^\S+$/
  validates_uniqueness_of :name, :case_sensitive => false

  def before_validation
    self.name.downcase!
  end
end
