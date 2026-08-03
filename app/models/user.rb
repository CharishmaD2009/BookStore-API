class User < ApplicationRecord
  has_secure_password

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy

  enum :role, {
    customer: 0,
    admin: 1
  }

  validates :name, presence: true

  validates :email,
            presence: true,
            uniqueness: true

  validates :role, presence: true
end