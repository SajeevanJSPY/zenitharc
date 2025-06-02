class CreateLoans < ActiveRecord::Migration[8.0]
  def change
    create_table :loans do |t|
      t.references :account, null: false, foreign_key: true
      t.decimal :principal_amount, null: false
      t.decimal :interest_rate, null: false
      t.integer :term_months, null: false
      t.string :status, null: false
      t.datetime :approved_at

      t.timestamps
    end
  end
end
