class Invoice < ApplicationRecord
  enum status: { "in progress": 0, cancelled: 1, completed: 2 }

  belongs_to :customer
  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates :status, presence: true

  scope :sort_oldest, -> {order('created_at asc')}

  def self.incomplete_invoices
    joins(:invoice_items)
      .where.not(invoice_items: { status: :shipped })
      .distinct
  end

  def items_belonging_to
    invoice_items.joins(:item)
                 .select('invoice_items.status, invoice_items.quantity, invoice_items.id as invoice_item_id, items.*')
  end

  def total_revenue
    invoice_items.sum('unit_price * quantity')
  end

  def invoice_total_revenue
    invoice_items.where('invoice_items.invoice_id = ?', id)
                 .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
