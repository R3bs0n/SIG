company = Company.find_or_create_by!(name: "SIG Comercio LTDA") do |record|
  record.document = "00.000.000/0001-00"
end

user = User.find_or_initialize_by(email: "admin@erpsig.local")
user.name = "Administrador"
user.role = "admin"
user.company = company
user.password = "password123"
user.password_confirmation = "password123"
user.save!

checking = company.financial_accounts.find_or_create_by!(name: "Banco Principal") do |record|
  record.account_type = "checking"
  record.opening_balance = 12_500
end

cash = company.financial_accounts.find_or_create_by!(name: "Caixa") do |record|
  record.account_type = "cash"
  record.opening_balance = 1_200
end

sales = company.categories.find_or_create_by!(name: "Vendas", kind: "income") { |record| record.color = "#16a34a" }
services = company.categories.find_or_create_by!(name: "Servicos", kind: "income") { |record| record.color = "#2563eb" }
suppliers = company.categories.find_or_create_by!(name: "Fornecedores", kind: "expense") { |record| record.color = "#dc2626" }
payroll = company.categories.find_or_create_by!(name: "Folha", kind: "expense") { |record| record.color = "#7c3aed" }
operations = company.categories.find_or_create_by!(name: "Operacional", kind: "expense") { |record| record.color = "#f59e0b" }

[
  ["Venda balcão", "income", 4_850, Date.current - 8.days, Date.current - 8.days, "paid", sales, checking],
  ["Contrato mensal", "income", 8_200, Date.current - 3.days, Date.current - 3.days, "paid", services, checking],
  ["Compra de mercadorias", "expense", 3_120, Date.current - 6.days, Date.current - 6.days, "paid", suppliers, checking],
  ["Adiantamento folha", "expense", 2_400, Date.current + 2.days, nil, "pending", payroll, checking],
  ["Material de escritorio", "expense", 620, Date.current - 1.day, Date.current - 1.day, "paid", operations, cash],
  ["Fornecedor recorrente", "expense", 1_950, Date.current + 7.days, nil, "pending", suppliers, checking]
].each do |description, kind, amount, due_date, paid_at, status, category, account|
  company.financial_transactions.find_or_create_by!(description: description, due_date: due_date) do |record|
    record.kind = kind
    record.amount = amount
    record.paid_at = paid_at
    record.status = status
    record.category = category
    record.financial_account = account
  end
end
