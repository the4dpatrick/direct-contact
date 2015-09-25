class Topic < ActiveRecord::Base
  belongs_to :digital_footprint
  # after_initialize :init

  # def init
  #   self.provider ||= ''
  #   self.value ||= ''
  # end
end
