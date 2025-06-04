module Customer
  class User < ApplicationRecord
    has_many :accounts
    has_many :login_logs
    validates :full_name, presence: true

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  end
end
