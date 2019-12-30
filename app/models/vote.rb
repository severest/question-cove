class Vote < ApplicationRecord
  belongs_to :voteable, polymorphic: true
  belongs_to :user

  def rails_admin_label
    "#{user.name} upvotes #{voteable_type} ##{votable.id}"
  end
end
