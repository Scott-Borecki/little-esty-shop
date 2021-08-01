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

  # ASK CAROLINE ABOUT THE COMMENTS HERE:
  # AR joins temp tables
  # calulations: that you want to know, not to save
  # relationship: want to save
  def invoice_items_for_invoice(invoice_id)
    invoice_items.where(invoice_id: invoice_id)
  end
end
