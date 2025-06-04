module Customer
  class Transaction < ApplicationRecord
    belongs_to :from, class_name: "Account"
    belongs_to :to, class_name: "Account"

    enum :status, {
      pending: "pending",
      completed: "completed",
      failed: "failed"
    }, suffix: true

    enum :transaction_type, {
      deposit: "deposit",
      withdrawal: "withdrawal",
      transfer: "transfer",
      payment: "payment"
    }, suffix: true

    validates :transaction_type, :status, :from, :to, presence: true
    validates :amount, numericality: { greater_than_or_equal_to: 0 }, presence: true

    validate :from_and_to_must_be_different, on: [ :create, :update ]

    private
    def from_and_to_must_be_different
      if from_id == to_id
        errors.add(:to, "must be different from from account")
      end
    end
  end
end
