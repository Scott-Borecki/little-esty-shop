class Invoice < ApplicationRecord
  enum status: { "in progress": 0, cancelled: 1, completed: 2 }

  belongs_to :customer

  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates :status, presence: true

  def invoice_total_revenue
    invoice_items.where('invoice_items.invoice_id = ?', id)
                 .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
