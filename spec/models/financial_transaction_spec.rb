require "rails_helper"

RSpec.describe FinancialTransaction do
  it "requires the category kind to match the transaction kind" do
    company = Company.create!(name: "Empresa Teste")
    account = company.financial_accounts.create!(name: "Caixa")
    category = company.categories.create!(name: "Vendas", kind: "income")

    transaction = company.financial_transactions.new(
      financial_account: account,
      category: category,
      description: "Conta de luz",
      kind: "expense",
      amount: 120,
      due_date: Date.current
    )

    expect(transaction).not_to be_valid
    expect(transaction.errors[:category]).to include("deve ser do mesmo tipo do lancamento")
  end
end
