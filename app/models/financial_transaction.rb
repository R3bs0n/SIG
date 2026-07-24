class FinancialTransaction < ApplicationRecord
  KINDS = %w[income expense].freeze
  STATUSES = %w[pending paid overdue canceled].freeze

  belongs_to :company
  belongs_to :financial_account
  belongs_to :category

  validates :description, :kind, :amount, :due_date, :status, presence: true
  validates :kind, inclusion: { in: KINDS }
  validates :status, inclusion: { in: STATUSES }
  validates :amount, numericality: { greater_than: 0 }
  validate :category_kind_matches_transaction_kind

  scope :income, -> { where(kind: "income") }
  scope :expense, -> { where(kind: "expense") }
  scope :paid, -> { where(status: "paid") }
  scope :pending, -> { where(status: "pending") }
  scope :overdue, -> { where(status: "overdue") }
  scope :recent, -> { order(due_date: :desc, created_at: :desc) }

  before_validation :sync_paid_status

  def signed_amount
    income? ? amount : -amount
  end

  def income?
    kind == "income"
  end

  def expense?
    kind == "expense"
  end

  private

  def sync_paid_status
    self.status = "paid" if paid_at.present?
  end

  def category_kind_matches_transaction_kind
    return if category.blank? || kind.blank? || category.kind == kind

    errors.add(:category, "deve ser do mesmo tipo do lancamento")
  end
end
