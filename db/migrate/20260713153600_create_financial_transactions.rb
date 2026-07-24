class CreateFinancialTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :financial_transactions do |t|
      t.references :company, null: false, foreign_key: true
      t.references :financial_account, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :description, null: false
      t.string :kind, null: false
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.date :due_date, null: false
      t.date :paid_at
      t.string :status, null: false, default: "pending"
      t.text :notes

      t.timestamps
    end

    add_index :financial_transactions, [:company_id, :due_date]
    add_index :financial_transactions, [:company_id, :kind]
    add_index :financial_transactions, [:company_id, :status]
  end
end
