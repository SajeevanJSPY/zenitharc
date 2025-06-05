module Arc
  class ArcAccount < ApplicationRecord
    validates :role, presence: true
    validates :account_number, presence: true, uniqueness: true

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

    enum :role, {
      superadmin: "superadmin",
      admin: "admin",
      manager: "manager",
      accountant: "accountant",
      staff: "staff"
    }, suffix: true

    before_validation :set_default_role, if: :new_record?

    private
    def set_default_role
      self.role ||= "staff"
    end
  end
end
