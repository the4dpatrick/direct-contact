module ContactsControllerHelper
  EMAIL_COOKIES_LIMIT = 25

  def set_emails_found_count_cookie
    cookies[:emails_found_count] ||= 0 unless user_signed_in?
  end

  def below_search_limit?
    below_users_monthly_limit || below_email_cookies_limit
  end

  def below_users_monthly_limit
    current_user.below_monthly_limit? if user_signed_in?
  end

  def below_email_cookies_limit
    cookies[:emails_found_count].to_i < EMAIL_COOKIES_LIMIT unless user_signed_in?
  end

  def record_and_search_for_contact
    current_user.attempt_search if user_signed_in?
    @contacts = Contact.find_contact(search_params)
    puts @contacts
    successful_search if @contacts
  end

  def downcase_search_params
    search_params[:first_name].downcase!
    search_params[:last_name].downcase!
    search_params[:domains].downcase!
    search_params
  end

  def successful_search
    if user_signed_in?
      current_user.successful_search
    else
      cookies[:emails_found_count] = cookies[:emails_found_count].to_i + 1
    end
  end

  def payup_dude
    if user_signed_in?
      view_context.link_to 'Please Upgrade your plan', edit_user_registration_path, class: 'underline'
    else
      view_context.link_to 'Upgrade to a paid plan', pricing_path, class: 'underline'
    end
  end
end
