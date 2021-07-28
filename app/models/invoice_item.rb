class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true
  enum status: {pending: 0, packaged: 1, shipped: 2 }
  belongs_to :invoice
  belongs_to :item
end
