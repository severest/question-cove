require "simplecov"
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
ENV['LOGIN_GOOGLE'] = '1'
ENV['LOGIN_SG'] = '1'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
end
