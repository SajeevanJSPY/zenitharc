module Customer
  class Loan < ApplicationRecord
    belongs_to :account

    validates :principal_amount, presence: true
    validates :interest_rate, presence: true
    validates :term_months, presence: true, numericality: { only_integer: true }
    validates :status, presence: true
    validates :approved_at, presence: true, if: :approved_status?

    enum :status, {
      pending: "pending",
      approved: "approved",
      rejected: "rejected"
    }, suffix: true
  end
end
