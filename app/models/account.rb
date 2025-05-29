class Account < ApplicationRecord
  belongs_to :user

  enum :account_type, {
    savings: "savings",
    current: "current",
    fixed: "fixed",
    joint: "joint"
  }, suffix: true

  enum :status, {
    active: "active",
    frozen: "frozen",
    closed: "closed",
    pending: "pending"
  }, suffix: true

  validates :user_id, presence: true
  validates :account_number, presence: true, uniqueness: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true
end
