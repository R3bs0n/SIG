class FinancialSummaryService
  def initialize(company:, range: Date.current.beginning_of_month..Date.current.end_of_month)
    @company = company
    @range = range
  end

  def call
    scoped = @company.financial_transactions.where(due_date: @range)
    income = scoped.income.sum(:amount)
    expense = scoped.expense.sum(:amount)

    {
      income: income,
      expense: expense,
      result: income - expense,
      pending: scoped.pending.sum(:amount),
      overdue_count: scoped.where(status: "pending").where("due_date < ?", Date.current).count,
      balance: @company.financial_accounts.sum(&:balance)
    }
  end
end
