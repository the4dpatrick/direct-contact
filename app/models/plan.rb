class Plan < ActiveRecord::Base
  has_many :users
  before_save :lower_case_attributes
  validate :name, presence: true, uniqueness: true
  validate :price, presence: true
  validate :monthly_limit, presence: true

  private

  def lower_case_attributes
    self.name.downcase!
  end
end
