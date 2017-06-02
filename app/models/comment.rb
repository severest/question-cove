class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, polymorphic: true

  validates :text, presence: true
end
