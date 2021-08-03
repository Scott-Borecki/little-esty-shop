class InvoiceItem < ApplicationRecord
  enum status: { pending: 0, packaged: 1, shipped: 2 }

  belongs_to :invoice
  belongs_to :item

  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true

  def find_item_name
    Item.where(id: item_id).first.name
  end

  def find_invoice_id
    Invoice.where(id: invoice_id).first.id
  end
end
