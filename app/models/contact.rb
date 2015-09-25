class Contact < ActiveRecord::Base
  include DirectContactModule
  has_many :photos, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :websites, dependent: :destroy
  has_many :organizations, dependent: :destroy
  has_many :social_profiles, dependent: :destroy
  has_one :demographic, dependent: :destroy
  has_one :digital_footprint, dependent: :destroy

  before_save :downcase_attributes

  class << self
    def find_contact(params)
      params[:domains] = params[:domains].split(/[\s,]+/)
      stored_contacts = find_records_matching_full_name_and_domains(params)
      if stored_contacts.present?
        stored_contacts
      else
        query_api_for_contacts params
      end
    end

    private

    def query_api_for_contacts(params)
      # Lookup contacts using the params and the API
      emails = DirectContactModule.lookup(params[:first_name],
                                          params[:last_name],
                                          params[:domains])

      contacts = find_records_matching_name_domain_or_email(params, emails)
      if contacts.present?
        contacts
      end
    end

    def find_records_matching_full_name_and_domains(params)
      contacts = Contact.where('full_name ~* ?',
                               "(#{params[:first_name]}|#{params[:last_name]}|#{params[:first_name][0]}\c.)" +
                               '\s?\w?\s?' +
                               "(#{params[:last_name]}|#{params[:first_name]}|#{params[:last_name][0]}\c.)")
        .where('email ~* ?', "(#{params[:domains][0]}|#{params[:domains][1] || 'nil'})")
      contacts if contacts.present?
    end

    def find_records_matching_name_domain_or_email(params, emails)
      contacts = uncached { find_records_matching_full_name_and_domains(params) }
      if contacts.present?
        contacts
      else
        contacts = Contact.where("email IN (?)", emails)
        contacts if contacts.present?
      end
    end
  end

  private

  def downcase_attributes
    self.email.downcase! if email
    self.first_name.downcase! if first_name
    self.last_name.downcase! if last_name
    self.middle_name.downcase! if middle_name
    self.full_name.downcase! if full_name
  end
end
