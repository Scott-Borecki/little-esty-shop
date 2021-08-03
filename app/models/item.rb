class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :enabled, inclusion: { in: [true, false] }

  def self.all_enabled
    where(enabled: true)
  end

  def self.all_disabled
    where(enabled: false)
  end

  def self.top_five_items_by_revenue
    select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .joins(:invoice_items)
    .joins(:invoices)
    .joins(:transactions)
    .where(transactions: {result: 1})
    .group(:id)
    .order(revenue: :desc)
    .limit(5)
  end
end
