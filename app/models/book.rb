class Book < ApplicationRecord
  belongs_to :category

  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :price, presence: true
  validates :stock, presence: true
end