require 'rails_helper'

module Customer
  RSpec.describe LoginLog, type: :model do
    before :example do
      @user = User.create(
        email: "user1@begins.rmb",
        password: "useruser1",
        full_name: "user user1"
      )
      @user.save!
    end

    context "model-level validation checks" do
      it "defaults `successful` to false if not explicitly set" do
        log = LoginLog.new(
          user_id: @user.id,
          ip_address: "192.168.13.41",
          user_agent: "linux/firefox",
          logged_in_at: Time.current,
        )
        expect(log.valid?).to eq true
        log.save!
        expect(log.reload.successful).to eq false
      end
    end

    context "database-level validation checks" do
      it "raises an error when `user_agent` is missing (not null constraint)" do
        log = LoginLog.new(
          user_id: @user.id,
          ip_address: "192.168.13.41",
          logged_in_at: Time.current,
          successful: true
        )
        expect {
          log.save!
        }.to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end
end
