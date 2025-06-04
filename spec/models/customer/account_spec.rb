require 'rails_helper'

module Customer
  RSpec.describe Account, type: :model do
    describe "validations" do
      before :example do
        @user = User.create(
          email: "user1@begins.rmb",
          password: "useruser1",
          full_name: "user user1"
        )
        @user.save!
      end

      context "when creating a valid account" do
        it "is valid with all required fields" do
          acc = Account.create(
            user: @user,
            account_number: "123456",
            account_type: "savings",
            balance: 100.00,
            status: "active"
          )
          expect(acc.validate).to be_truthy
          expect(acc).to be_savings_account_type
          expect(acc).to be_active_status
          expect(acc.user).not_to be_nil
          expect(acc.account_number).to eq "123456"
          expect(acc.balance).to eq 100.0
        end
      end

      context "invalid arguments and fields" do
        it "when account_type is invalid" do
          expect {
            Account.new(
              account_number: "123456",
              account_type: "saving",
              balance: 100.0,
              status: "active"
            ).to raise_error(ArgumentError)
          }
        end

        it "invalid without an associated user" do
          account = Account.new(
            account_number: "123456",
            account_type: "savings",
            balance: 100.0,
            status: "active"
          )
          expect(account.validate).to be_falsy
          expect(account.errors.messages[:user]).to include("must exist")
          expect(account).to be_active_status
          expect(account).to be_savings_account_type
        end
      end
    end
  end
end
