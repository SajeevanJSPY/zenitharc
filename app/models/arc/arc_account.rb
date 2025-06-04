module Arc
  class ArcAccount < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

    validates :role, :account_number, presence: true

    enum :role, [
      :superadmin,
      :admin,
      :manager,
      :accountant,
      :staff
    ], suffix: true

    after_initialize :set_default_role, if: :new_record?

    private
    def set_default_role
      self.role ||= "staff"
    end
  end
end
