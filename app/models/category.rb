class Category < ApplicationRecord
  KINDS = %w[income expense].freeze

  belongs_to :company
  has_many :financial_transactions, dependent: :restrict_with_error

  validates :name, :kind, :color, presence: true
  validates :kind, inclusion: { in: KINDS }
end
