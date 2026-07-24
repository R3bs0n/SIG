class CreateFinancialAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :financial_accounts do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name, null: false
      t.string :account_type, null: false, default: "checking"
      t.decimal :opening_balance, precision: 15, scale: 2, null: false, default: 0
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
