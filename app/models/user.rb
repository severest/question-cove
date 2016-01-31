class User < ActiveRecord::Base
  include Clearance::User
  extend FriendlyId
  friendly_id :email, use: :slugged
  has_many :questions
  has_many :answers
end
