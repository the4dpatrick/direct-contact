class Score < ActiveRecord::Base
  belongs_to :digital_footprint
  # after_initialize :init

  # def init
  #   self.provider ||= ''
  #   self.network_type ||= ''
  #   self.value ||= 0
  # end
end
