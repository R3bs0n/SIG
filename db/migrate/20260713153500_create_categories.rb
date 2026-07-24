class CreateCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :categories do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name, null: false
      t.string :kind, null: false
      t.string :color, null: false, default: "#2563eb"

      t.timestamps
    end

    add_index :categories, [:company_id, :kind, :name], unique: true
  end
end
