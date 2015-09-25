module ContactsHelper
  def open_pricing_modal?
    @contacts.present? &&
      cookies[:emails_found_count].to_i >= 5 &&
      cookies[:emails_found_count].to_i % 5 == 0
  end

  def first_successful_search?
    @contacts.present? && cookies[:emails_found_count] == 1
  end

  def title_at_company_for(contact)
    if contact.organizations.first
      contact.organizations.first.title + ' at ' + contact.organizations.first.name
    end
  end

  def default_or_photo_for(contact)
    if contact.photos.first
      image_tag contact.photos.first.url
    else
      image_tag 'https://s3-us-west-1.amazonaws.com/direct-contact/dflt-avatar.jpg'
    end
  end
end
