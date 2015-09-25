class Website < ActiveRecord::Base
  belongs_to :contact
  # after_initialize :init

  # def init
  #   self.url ||= ''
  # end
end
