class ApplicationController < ActionController::Base
  include Clearance::Controller
  before_action :require_login
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def require_login
    if Rails.configuration.demo_mode
      sign_in(User.find(1))
    else
      super
    end
  end
end
