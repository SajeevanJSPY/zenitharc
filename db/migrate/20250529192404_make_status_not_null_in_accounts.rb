class MakeStatusNotNullInAccounts < ActiveRecord::Migration[8.0]
  def change
    change_column_null :accounts, :status, false
  end
end
