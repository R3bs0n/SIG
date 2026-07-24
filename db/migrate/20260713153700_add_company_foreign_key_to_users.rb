class AddCompanyForeignKeyToUsers < ActiveRecord::Migration[8.1]
  def change
    change_column_null :users, :name, false
    change_column_default :users, :role, from: nil, to: "admin"
    change_column_null :users, :role, false, "admin"
    change_column_null :users, :company_id, false
    add_foreign_key :users, :companies
  end
end
