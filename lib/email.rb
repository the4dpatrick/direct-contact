module Email
  def self.to(email_address, template_name)
    case template_name
    when :expiration
      ExpirationEmailWorker.perform_async(email_address)
    end
  end
end
