class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book

  validates :quantity,
            presence: true,
            numericality: { greater_than: 0 }

  validates :price,
            presence: true
end