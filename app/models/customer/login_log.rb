module Customer
  class LoginLog < ApplicationRecord
    belongs_to :user

    validates :ip_address, :logged_in_at, presence: true
  end
end
