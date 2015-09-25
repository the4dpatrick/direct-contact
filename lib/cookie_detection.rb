module CookieDetection

  def self.included(base)
    base.before_action :cookies_required, except: ["cookie_test"]
  end

  # checks for presence of "cookie_test" cookie
  # (should have been set by cookies_required before_filter)
  # if cookie is present, continue normal operation
  # otherwise show cookie warning at "shared/cookies_required"
  def cookie_test
    if cookies["cookie_test"].blank?
      logger.warn("=== cookies are disabled")
      render "shared/cookies_required"
    else
      redirect_back_or_default(root_path)
    end
  end

  protected

  # checks for presence of "cookie_test" cookie.
  # If not present, redirects to cookies_test action
  def cookies_required
    return true unless cookies["cookie_test"].blank?
    cookies["cookie_test"] = Time.now
    session[:return_to] = request.url
    redirect_to(cookies_test_path)
  end

  private

  def redirect_back_or_default(default)
    redirect_to session[:return_to] || default
    session[:return_to] = nil
  end
end
