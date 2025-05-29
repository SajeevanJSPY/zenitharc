require 'rails_helper'

RSpec.describe Account, type: :model do
  context "passing invalid arguments" do
    it "account creation should fail for the invalid account_type" do
      expect {
        Account.new(
          account_number: "123456",
          account_type: "saving",
          balance: 100.0,
          status: "active"
        ).to raise_error(ArgumentError)
      }
    end

    it "account without the user should be invalid" do
      account = Account.new(
        account_number: "123456",
        account_type: "savings",
        balance: 100.0,
        status: "active"
      )
      expect(account.valid?).to eq false
    end
  end
end
