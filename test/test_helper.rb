require "simplecov"
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
ENV['LOGIN_GOOGLE'] = '1'
ENV['LOGIN_SG'] = '1'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
end
