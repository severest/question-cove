class LoggedinController < ApplicationController
  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  def require_login
    unless current_user != nil
      session[:return_to] = request.url
      return redirect_to login_url
    end

    unless current_user.email =~ Rails.configuration.domain_whitelist
      return redirect_to not_allowed_url
    end
  end

  def redirect_to_target_or_default
    redirect_to(session[:return_to] || root_url)
    session[:return_to] = nil
  end
end
