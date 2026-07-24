class DashboardQuery
  def initialize(company:, range: Date.current.beginning_of_month..Date.current.end_of_month)
    @company = company
    @range = range
  end

  def monthly_chart
    transactions = @company.financial_transactions.where(due_date: @range)
    income = transactions.income.group("DATE(due_date)").sum(:amount).transform_keys(&:to_date)
    expense = transactions.expense.group("DATE(due_date)").sum(:amount).transform_keys(&:to_date)

    @range.map do |date|
      {
        label: I18n.l(date, format: "%d/%m"),
        income: income[date].to_f,
        expense: expense[date].to_f
      }
    end
  end

  def by_category
    @company.financial_transactions
      .expense
      .where(due_date: @range)
      .joins(:category)
      .group("categories.name", "categories.color")
      .sum(:amount)
      .map { |(name, color), amount| { name: name, color: color, amount: amount.to_f } }
  end

  def latest_transactions(limit: 8)
    @company.financial_transactions.includes(:category, :financial_account).recent.limit(limit)
  end
end
