class Merchant < ApplicationRecord
  has_many :items, :dependent => :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates :name, presence: true
  validates :enabled, inclusion: { in: [true, false] }

  def self.enabled_merchants
    where(enabled: true)
  end

  def self.disabled_merchants
    where(enabled: false)
  end

  def enabled?
    enabled
  end

  def self.top_five_merchants_by_revenue
    select('merchants.*', 'SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(:transactions)
      .where(transactions: { result: :success })
      .group('merchants.id')
      .order('revenue desc')
      .limit(5)
  end

  def self.total_revenue_generated_by_merchant(merchant)
    if joins(:transactions)
         .where(transactions: { result: :success }, merchants: { id: merchant.id })
         .count
         .positive?
      select('merchants.*', 'SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
        .joins(:transactions)
        .where(transactions: { result: :success }, merchants: { id: merchant.id })
        .group('merchants.id')
        .first
        .revenue
    else
      0
    end
  end

  # HACK (Scott Borecki): Figure out another way to do this
  def total_revenue
    Merchant.total_revenue_generated_by_merchant(self)
  end

  def best_day
    invoice_items.select('invoice.created_at', 'SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(:transactions)
      .where(transactions: { result: :success })
      .group('invoice.created_at')
      .order('DATE(invoice.created_at), revenue desc')
  end
end
