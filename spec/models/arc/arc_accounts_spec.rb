require 'rails_helper'

module Arc
  RSpec.describe ArcAccount, type: :model do
    describe "validations" do
      context "when creating a valid account" do
        it "is valid with all required fields" do
          arc_acc = ArcAccount.new(
            email: "admin@gmail.com",
            password: "adminadmin",
            account_number: "100000000"
          )
          expect(arc_acc.validate).to be_truthy
          expect(arc_acc).to be_staff_role
          expect(arc_acc.account_number).to eq "100000000"
        end
      end

      context "invalid arguments and fields" do
        it "when account_type is invalid" do
          expect {
            ArcAccount.create(
              email: "admin@gmail.com",
              password: "adminadmin",
              account_number: "100000000",
              role: "stafff"
            ).to raise_error(ArgumentError)
          }
        end
      end
    end
  end
end
