class Company < ApplicationRecord
  has_one_attached :logo

  has_many :users, dependent: :destroy
  has_many :financial_accounts, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :financial_transactions, dependent: :destroy

  validates :name, presence: true
end
