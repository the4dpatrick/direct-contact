module DirectContactModule
  class API
    class << self
      def query(first_name, last_name, domains)
        permutations = permutate first_name, last_name, domains
        found_people = permutations.map { |email| process_email email }
        found_people.compact
      end

      private

      def process_email(email)
        if Contact.where("email ILIKE ?", "#{email}").present?
          email unless free_email_service?(email)
        else
          begin
            full_contact_person_query(email)
          rescue FullContact::NotFound
            # Error logging
          end
        end
      end

      def full_contact_person_query(email)
        person = FullContact.person(email: email)
        if person.status == 200
          person.contact_info ||= {}
          person.contact_info.email = email
          person.contact_info.free_email = true if free_email_service?(email)
          person
          # could use webhook for Status == 202
        end
      end

      def free_email_service?(email)
        email =~ /(gmail.com|hotmail.com|yahoo.com|live.com|outlook.com|mail.com|inbox.com|aol.com|me.com)/
      end

      def permutate(first_name, last_name, domains)
        first_initial = first_name[0]
        last_initial = last_name[0]

        # Define each name permutation manually
        name_permutations = <<PERMS
{first_name}
{last_name}
{first_name}{last_name}
{first_name}.{last_name}
{first_initial}{last_name}
{first_initial}.{last_name}
{first_name}{last_initial}
{first_name}.{last_initial}
{first_initial}{last_initial}
{first_initial}.{last_initial}
{last_name}{first_name}
{last_name}.{first_name}
{last_name}{first_initial}
{last_name}.{first_initial}
{last_initial}{first_name}
{last_initial}.{first_name}
{last_initial}{first_initial}
{last_initial}.{first_initial}
{first_name}-{last_name}
{first_initial}-{last_name}
{first_name}-{last_initial}
{first_initial}-{last_initial}
{last_name}-{first_name}
{last_name}-{first_initial}
{last_initial}-{first_name}
{last_initial}-{first_initial}
{first_name}_{last_name}
{first_initial}_{last_name}
{first_name}_{last_initial}
{first_initial}_{last_initial}
{last_name}_{first_name}
{last_name}_{first_initial}
{last_initial}_{first_name}
{last_initial}_{first_initial}
PERMS

        # substitutions to get all permutations to an Array
        name_permutations = name_permutations.gsub('{first_name}', first_name)
          .gsub('{last_name}', last_name)
          .gsub('{first_initial}', first_initial)
          .gsub('{last_initial}', last_initial)
          .split($/)

        domains = ['@'].product domains
        name_and_domains = name_permutations.product domains

        # combine names and domains
        # return permuations
        permutations = name_and_domains.map(&:join)
      end
    end
  end
end
