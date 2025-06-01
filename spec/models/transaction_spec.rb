require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before :example do
    @user1 = User.create(
      email: "user1@begins.rmb",
      password: "useruser1",
      role: "customer",
      full_name: "user user1"
    )
    @user2 = User.create(
      email: "user2@begins.rmb",
      password: "useruser2",
      role: "customer",
      full_name: "user user2"
    )
    @user3 = User.create(
      email: "user3@begins.rmb",
      password: "useruser3",
      role: "customer",
      full_name: "user user3"
    )
    @user1.save!
    @user2.save!
    @user3.save!

    @account1 = Account.create(
      user: @user1,
      account_number: "123456",
      account_type: "savings",
      balance: 100.0,
      status: "active"
    )
    @account2 = Account.create(
      user: @user2,
      account_number: "123457",
      account_type: "savings",
      balance: 1000.0,
      status: "active"
    )
    @account1.save!
    @account2.save!
  end

  context "model-level validation checks" do
    it "create a valid `Transaction` with minimum required fields" do
      t = Transaction.create!(
        from: @account1,
        to: @account2,
        amount: 1000.00,
        transaction_type: "deposit",
      )
      expect(t.validate).to be_truthy
      expect(t.save).to be_truthy

      t.reload
      expect(t.reference_code).to be_nil
      expect(t.description).to be_nil
      expect(t).to be_pending_status
      expect(t).to be_deposit_transaction_type
    end

    it "raises error for invalid transaction_type value" do
      expect {
        Transaction.new(
          amount: 1000.00,
          transaction_type: "depositt"
        )
      }.to raise_error(ArgumentError)
    end

    it "raises error for invalid status value" do
      expect {
        Transaction.new(
          amount: 1000.00,
          transaction_type: "deposit",
          status: "not_completed"
        )
      }.to raise_error(ArgumentError)
    end

    it "raises error when required fields are missing" do
      expect {
        Transaction.create!(
          transaction_type: "deposit",
          status: "pending"
        )
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "raises error when `from` and `to` are the same account" do
      expect {
        Transaction.create!(
          from: @account1,
          to: @account1,
          amount: 1000.00,
          transaction_type: "deposit",
          status: "pending"
        )
      }.to raise_error(ActiveRecord::RecordInvalid, /must be different from from account/)
    end
  end
end
