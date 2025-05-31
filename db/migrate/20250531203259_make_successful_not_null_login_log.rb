class MakeSuccessfulNotNullLoginLog < ActiveRecord::Migration[8.0]
  def change
    change_column_null :login_logs, :successful, false
    change_column_default :login_logs, :successful, false
  end
end
