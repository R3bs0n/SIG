require "rails_helper"

RSpec.describe FinancialSummaryService do
  it "calculates income, expenses, result and balance for the selected company" do
    company = Company.create!(name: "Empresa Teste")
    account = company.financial_accounts.create!(name: "Conta Corrente", opening_balance: 100)
    income_category = company.categories.create!(name: "Vendas", kind: "income")
    expense_category = company.categories.create!(name: "Fornecedores", kind: "expense")

    company.financial_transactions.create!(
      financial_account: account,
      category: income_category,
      description: "Receita",
      kind: "income",
      amount: 250,
      due_date: Date.current,
      paid_at: Date.current
    )
    company.financial_transactions.create!(
      financial_account: account,
      category: expense_category,
      description: "Despesa",
      kind: "expense",
      amount: 80,
      due_date: Date.current,
      status: "pending"
    )

    summary = described_class.new(company: company).call

    expect(summary[:income]).to eq(250)
    expect(summary[:expense]).to eq(80)
    expect(summary[:result]).to eq(170)
    expect(summary[:pending]).to eq(80)
    expect(summary[:balance]).to eq(350)
  end
end
