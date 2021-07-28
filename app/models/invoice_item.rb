class InvoiceItem < ApplicationRecord
  validates :quantity, :unit_price, :status, presence: true, numericality: true

  belongs_to :invoice
  belongs_to :item
end
