class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :account_number, null: false
      t.string :account_type, null: false
      t.decimal :balance, precision: 15, scale: 2, default: 0.0
      t.string :status

      t.timestamps
    end
    add_index :accounts, :account_number, unique: true
  end
end
