require 'rails_helper'

module Customer
  RSpec.describe Loan, type: :model do
    before :example do
      @user1 = User.create!(
        email: "user1@begins.rmb",
        password: "useruser1",
        full_name: "user user1"
      )
      @account1 = Account.create!(
        user: @user1,
        account_number: "123456",
        account_type: "savings",
        balance: 100.0,
        status: "active"
      )
      @loan1 = Loan.create!(
          account: @account1,
          principal_amount: 1000,
          interest_rate: 10.0,
          term_months: 10,
          status: "pending"
      )
    end

    context "when creating a valid loan" do
      it "creates a loan with all required fields and pending status" do
        loan = Loan.create(
          account: @account1,
          principal_amount: 1000,
          interest_rate: 10.0,
          term_months: 10,
          status: "pending"
        )

        expect(loan.validate).to be_truthy
        loan.reload
        expect(loan.save).to be_truthy
        expect(loan).to be_pending_status
        expect(loan.principal_amount).to eq 1000
        expect(loan.term_months).to eq 10
        expect(loan.interest_rate).to eq 10.0
        expect(loan.approved_at).to be_nil
      end
    end

    context "when loan status is changed to approved" do
      it "requires approved_at to be present" do
        expect(@loan1).to be_pending_status

        @loan1.status = "approved"
        expect(@loan1.validate).to be_falsy
        expect(@loan1.errors.messages[:approved_at]).to include(/can't be blank/)

        @loan1.approved_at = Time.current
        expect(@loan1.validate).to be_truthy
        expect(@loan1.errors.messages.empty?).to be_truthy
      end
    end
  end
end
