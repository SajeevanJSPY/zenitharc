class AddOtherFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :full_name, :string, null: false
  end
end
