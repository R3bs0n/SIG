class User < ApplicationRecord
  ROLES = %w[admin finance analyst].freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company

  validates :name, :role, presence: true
  validates :role, inclusion: { in: ROLES }

  def admin?
    role == "admin"
  end
end
