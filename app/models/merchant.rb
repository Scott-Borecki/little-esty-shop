class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def unique_invoices
    invoices.uniq
  end

  def invoice_items_for_invoice(invoice_id)
    invoice_items.where('invoice_items.invoice_id = ?', invoice_id)
  end
end
