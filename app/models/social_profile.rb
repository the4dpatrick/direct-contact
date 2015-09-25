class SocialProfile < ActiveRecord::Base
  belongs_to :contact
  # after_initialize :init

  # def init
  #   self.network_type ||= ''
  #   self.type_name ||= ''
  #   self.username ||
end
