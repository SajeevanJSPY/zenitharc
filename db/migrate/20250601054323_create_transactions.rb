class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :from, null: false, foreign_key: { to_table: :accounts }
      t.references :to, null: false, foreign_key: { to_table: :accounts }
      t.decimal :amount, null: false, precision: 15, scale: 2
      t.string :transaction_type, null: false
      t.string :status, null: false, default: "pending"
      t.string :reference_code
      t.text :description

      t.timestamps
    end
  end
end
