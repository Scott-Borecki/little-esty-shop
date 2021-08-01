class Invoice < ApplicationRecord
  enum status: { "in progress": 0, cancelled: 1, completed: 2 }

  belongs_to :customer
  
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items

  validates :status, presence: true

  def items_belonging_to
    invoice_items.joins(:item).select('invoice_items.status, invoice_items.quantity, invoice_items.id as invoice_item_id, items.*')
  end

  def total_revenue
    invoice_items.sum('unit_price * quantity')
  end
end
