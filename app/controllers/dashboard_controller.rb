class DashboardController < ApplicationController
  def index
    range = Date.current.beginning_of_month..Date.current.end_of_month
    query = DashboardQuery.new(company: current_user.company, range: range)

    @summary = FinancialSummaryService.new(company: current_user.company, range: range).call
    @chart_data = query.monthly_chart
    @category_data = query.by_category
    @latest_transactions = query.latest_transactions
  end
end
