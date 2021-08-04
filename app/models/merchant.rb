class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates :name, presence: true
  validates :enabled, inclusion: { in: [true, false] }

  def self.any_successful_transactions?(merchant)
    joins(:transactions)
      .where(transactions: { result: :success }, merchants: { id: merchant.id })
      .count
      .positive?
  end

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
      .group('merchants.id')
      .order('revenue desc')
      .limit(5)
  end

  def self.total_revenue_generated_by_merchant(merchant)
    if any_successful_transactions?(merchant)
      select(
        'merchants.*',
        'SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue'
      )
        .joins(:transactions)
        .where(
          transactions: { result: :success },
          merchants: { id: merchant.id }
        )
        .group('merchants.id')
        .first
        .revenue
    else
      0
    end
  end

  def top_five_customers
    items.joins(invoices: [:transactions, :customer])
         .select(
           'customers.*', 'count(transactions.id) as total_transactions',
           'customers.id as customer_id')
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

  # HACK: (Scott Borecki) Figure out another way to do this
  def total_revenue
    Merchant.total_revenue_generated_by_merchant(self)
  end

  # TODO: (Scott Borecki) Method not complete.
  def top_day
    invoice_items.select('invoice.created_at', 'SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
                 .joins(:transactions)
                 .where(transactions: { result: :success })
                 .group('invoice.created_at')
                 .order('DATE(invoice.created_at), revenue desc')
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
