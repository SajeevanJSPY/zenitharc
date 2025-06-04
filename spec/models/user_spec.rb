require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    context "when creating a valid user" do
      it "is valid with minimum required fields" do
        user = User.new(
          email: "user@begins.rmb",
          password: "useruser1",
          full_name: "user user1",
        )
        expect(user.validate).to be_truthy
        expect(user.save).to be_truthy

        user.reload
        expect(user.email).to eq "user@begins.rmb"
        expect(user.password).to eq "useruser1"
        expect(user.full_name).to eq "user user1"
        expect(user.encrypted_password).to be_truthy
        expect(user.reset_password_token).to be_nil
        expect(user.reset_password_sent_at).to be_nil
        expect(user.remember_created_at).to be_nil
      end
    end

    context "when password is invalid" do
      it "is invalid with a too-short password" do
        user = User.create(
          email: "user1@begins.rmb",
          password: "only",
          full_name: "user user1"
        )

        expect(user.validate).to be_falsy
        expect(user.errors[:password]).to include(a_string_matching(/too short/i))
      end
    end

    context "when email is not unique" do
      it "is invalid with a duplicate email" do
        User.create!(
          email: "user1@begins.rmb",
          password: "123456",
          full_name: "user user1"
        )

        user = User.new(
          email: "user1@begins.rmb",
          password: "123456",
          full_name: "user user2"
        )

        expect(user).not_to be_valid
        expect(user.errors.messages[:email]).to include("has already been taken")
      end
    end
  end
end
