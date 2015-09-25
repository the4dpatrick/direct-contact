class ContactsController < ApplicationController
  include ContactsControllerHelper

  def index
    set_emails_found_count_cookie
    if below_search_limit? && search_params.present?
      downcase_search_params
      record_and_search_for_contact
    elsif !below_search_limit?
      flash.now[:alert] =  "You have reached your searching limit. #{ payup_dude }".html_safe
    end

    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end

  private

  def search_params
    params.permit(:first_name, :last_name, :domains)
  end
end
