class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates :name, presence: true
  validates :enabled, inclusion: { in: [true, false] }

  def self.disabled_merchants
    where(enabled: false)
  end

  def self.enabled_merchants
    where(enabled: true)
  end

  def self.top_five_merchants_by_revenue
    select('merchants.*',
           'SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .joins(:transactions)
      .where(transactions: { result: :success })
      .group(:id)
      .order('revenue desc')
      .limit(5)
  end

  def top_five_customers
    items.joins(invoices: [:transactions, :customer])
         .select(
           'customers.*',
           'count(transactions.id) as total_transactions',
           'customers.id as customer_id'
         )
         .group('customers.id')
         .where(transactions: { result: :success })
         .order('total_transactions desc')
         .limit(5)
  end

  def invoice_items_to_ship
    invoice_items.where(invoice_items: { status: :shipped })
  end

  def enabled?
    enabled
  end

  def top_revenue_day
    invoices
      .select(
        'invoices.created_at',
        'SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue'
      )
      .joins(:transactions)
      .where(transactions: { result: :success })
      .group(:id)
      .order('revenue desc', 'created_at desc')
      .first
      .formatted_time
  end

  def unique_invoices
    invoices.uniq
  end

  def invoice_items_for_invoice(invoice_id)
    invoice_items.where(invoice_id: invoice_id)
  end
end
