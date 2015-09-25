class Organization < ActiveRecord::Base
  belongs_to :contact
  # after_initialize :init

  # def init
  #   self.is_primary ||= false
  #   self.name ||= ''
  #   self.start_date ||= nil
  #   self.end_date ||= nil
  #   self.title ||= ''
  # end
end
