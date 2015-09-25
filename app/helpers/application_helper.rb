module ApplicationHelper
  def stripe_page?
    controller_name == 'registrations'
  end

  def mixpanel_track(message, opts={})
    if !user_signed_in?
      haml_tag :script, type: 'text/javascript' do
        haml_concat "mixpanel.track('#{message}', #{opts.to_json});"
      end
    end
  end
end
