class TransactionCreateService
  def initialize(company:, user:, attributes:)
    @company = company
    @user = user
    @attributes = attributes
  end

  def call
    @company.financial_transactions.create(@attributes)
  end
end
