class User < ApplicationRecord
  has_many :accounts
  has_many :login_logs
  validates :role, presence: true
  validates :full_name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, {
    customer: "customer",
    staff: "staff",
    accountant: "accountant",
    support: "support",
    manager: "manager",
    compliance: "compliance",
    admin: "admin",
    superadmin: "superadmin"
  }, suffix: true

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= "customer"
  end
end
