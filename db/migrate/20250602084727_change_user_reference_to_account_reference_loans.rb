class ChangeUserReferenceToAccountReferenceLoans < ActiveRecord::Migration[8.0]
  def change
    rename_column :loans, :user_id, :account_id
  end
end
