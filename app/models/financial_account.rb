class FinancialAccount < ApplicationRecord
  ACCOUNT_TYPES = %w[checking savings cash credit_card investment].freeze

  belongs_to :company
  has_many :financial_transactions, dependent: :restrict_with_error

  validates :name, :account_type, presence: true
  validates :account_type, inclusion: { in: ACCOUNT_TYPES }
  validates :opening_balance, numericality: true

  scope :active, -> { where(active: true) }

  def balance
    income = financial_transactions.income.paid.sum(:amount)
    expense = financial_transactions.expense.paid.sum(:amount)
    opening_balance + income - expense
  end
end
