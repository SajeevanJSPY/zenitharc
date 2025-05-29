require 'rails_helper'

RSpec.describe User, type: :model do
  context "remove the user for invalid parameters" do
    it "validating the password" do
      expect {
        User.create!(
          email: "user1@begins.rmb",
          password: "only",
          full_name: "user user1"
        )
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
