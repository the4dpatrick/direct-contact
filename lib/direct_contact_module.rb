require 'direct_contact_module/api.rb'

module DirectContactModule
  class << self
    def lookup(first_name, last_name, domains)
      found_emails_contacts = DirectContactModule::API.query(first_name, last_name, domains)
      create_contacts_and_return_emails found_emails_contacts
    end

    private

    def create_contacts_and_return_emails(contacts)
      emails = []
      contacts.each do |contact|
        if contact.is_a? String
          emails << contact
        else
          create_contact_profile contact
          emails << contact.contact_info.email unless contact.contact_info.free_email
        end
      end
      emails
    end

    def create_contact_profile(contact)
      ## Basic Contact Info ##
      create_contact(contact) if contact.contact_info
      ## Photos ##
      create_contact_photos(contact) if contact.photos
      ## Organizations ##
      create_contact_organizations(contact) if contact.organizations

      # USE SIDEKIQ WORKER FOR SPEED
      ## Chat ##
      create_contact_chats(contact) if contact.chats
      ## Demographics ##
      create_contact_demographic(contact) if contact.demographics
      ## Digital Footprint ##
      create_contact_digital_footprint(contact) if contact.digital_footprint
      ## Websites ##
      create_contact_websites(contact) if contact.websites
      ## Social Profiles ##
      create_contact_social_profiles(contact) if contact.social_profiles
    end

    def create_contact(contact)
      @contact = Contact.new(full_name: contact.contact_info.full_name,
                             first_name: contact.contact_info.given_name,
                             last_name: contact.contact_info.family_name,
                             email: contact.contact_info.email)
      if contact.contact_info.middle_name.present?
        @contact.middle_name = contact.contact_info.middle_name.join(',')
      end
      @contact.save
    end

    def create_contact_photos(contact)
      contact.photos.each do |photo|
        # remove FullContact's default avatar and replace with DirectContact's
        male_avatar = 'https://d2ojpxxtu63wzl.cloudfront.net/static/8379c996ca8722959703a63371994037_737e9bb8b740ddc678bd9d5b0bc22ead8c5ed710a8ca0ddaf8107b1b851cd85d'
        female_avatar = 'https://d2ojpxxtu63wzl.cloudfront.net/static/42a40d00f3d0d583325fed112628eb7a_aab783692c79ea1b323b6dcb5db380238ac126367824b099bcd0f40d2b541f94'
        direct_contact_default_avatar = 'https://s3-us-west-1.amazonaws.com/direct-contact/dflt-avatar.jpg'
        if photo.url == male_avatar || photo.url == female_avatar || photo.url.nil?
          photo.url = direct_contact_default_avatar
        end

        Photo.create!(contact_id: @contact.id,
                      network_type: photo.type,
                      type_name: photo.type_name,
                      url: photo.url,
                      is_primary: photo.is_primary)
      end
    end

    def create_contact_organizations(contact)
      contact.organizations.each do |org|
        start_date = DateTime.strptime(org.start_date.to_s, '%Y-%m') rescue nil
        end_date = DateTime.strptime(org.end_date.to_s, '%Y-m') rescue nil

        Organization.create!(contact_id: @contact.id,
                             is_primary: org.is_primary,
                             name: org.name,
                             start_date: start_date,
                             end_date: end_date,
                             title: org.title)
      end
    end

    def create_contact_chats(contact)
      contact.chats.each do |chat|
        Chat.create!(contact_id: @contact.id,
                     client: chat.client,
                     handle: chat.handle)
      end
    end

    def create_contact_demographic(contact)
      Demographic.create!(contact_id: @contact.id,
                          gender: contact.demographics.gender,
                          age: contact.demographics.age,
                          location_general: contact.demographics.location_general,
                          age_range: contact.demographics.age_range)
    end

    def create_contact_digital_footprint(contact)
      @digital_footprint = DigitalFootprint.create!(contact_id: @contact.id)
      create_digital_footprint_score(contact) if contact.digital_footprint.scores
      create_digital_footprint_topics(contact) if contact.digital_footprint.topics
    end

    def create_digital_footprint_score(contact)
      contact.digital_footprint.scores.each do |score|
        Score.create!(digital_footprint_id: @digital_footprint.id,
                      provider: score.provider,
                      network_type: score.type,
                      value: score.value)
      end
    end

    def create_digital_footprint_topics(contact)
      contact.digital_footprint.topics.each do |topic|
        Topic.create!(digital_footprint_id: @digital_footprint.id,
                      provider: topic.provider,
                      value: topic.value)
      end
    end

    def create_contact_websites(contact)
      contact.websites.each do |website|
        Website.create!(contact_id: @contact.id, url: website.url)
      end
    end

    def create_contact_social_profiles(contact)
      contact.social_profiles.each do |profile|
        SocialProfile.create!(contact_id: @contact.id,
                              network_type: profile.type,
                              type_name: profile.type_name,
                              username: profile.username,
                              url: profile.url,
                              account_id: profile.id,
                              bio: profile.bio,
                              followers: profile.followers,
                              following: profile.following)
      end
    end
  end # End of self class
end # End of DirectContactModule
