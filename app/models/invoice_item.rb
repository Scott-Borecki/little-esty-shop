class InvoiceItem < ApplicationRecord
  enum status: { pending: 0, packaged: 1, shipped: 2 }

  belongs_to :invoice
  belongs_to :item

  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true

  def self.top_day
    select('invoice.created_at', 'SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(invoices: :transactions)
      .where(transactions: { result: :success })
      .group('invoice.created_at')
      .order('invoice.created_at, revenue desc')
  end
end
