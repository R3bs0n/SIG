class FinancialTransactionsQuery
  def initialize(scope, params = {})
    @scope = scope
    @params = params
  end

  def call
    relation = @scope.includes(:category, :financial_account).recent
    relation = relation.where(kind: @params[:kind]) if @params[:kind].present?
    relation = relation.where(status: @params[:status]) if @params[:status].present?
    relation = relation.where(category_id: @params[:category_id]) if @params[:category_id].present?
    relation = relation.where("due_date >= ?", @params[:from]) if @params[:from].present?
    relation = relation.where("due_date <= ?", @params[:to]) if @params[:to].present?
    relation
  end
end
