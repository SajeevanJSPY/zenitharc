class CreateLoginLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :login_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :ip_address, null: false
      t.text :user_agent, null: false
      t.boolean :successful
      t.datetime :logged_in_at, null: false

      t.timestamps
    end
  end
end
