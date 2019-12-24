class LoggedinController < ApplicationController
  before_action :require_login
end
