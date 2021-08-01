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

  def self.top_revenue_day_by_merchant(merchant)
    # select(
    #   'merchants.*',
    #   'invoices.created_at',
    #   'SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue'
    # )
    #   .joins(:transactions)
    #   .where(
    #     transactions: { result: :success },
    #     merchants: { id: merchant.id }
    #   )
    #   .group('invoices.created_at', 'merchants.id')
    #   .order('revenue desc')
    find_by_sql(<<-SQL.squish)
      SELECT
        merchants.id,
        invoices.created_at,
        SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue
      FROM
        "merchants"
      INNER JOIN
        "items"
      ON
        "items"."merchant_id" = "merchants"."id"
      INNER JOIN
        "invoice_items"
      ON
        "invoice_items"."item_id" = "items"."id"
      INNER JOIN
        "invoices"
      ON
        "invoices"."id" = "invoice_items"."invoice_id"
      INNER JOIN
        "transactions"
      ON
        "transactions"."invoice_id" = "invoices"."id"
      WHERE
        "transactions"."result" = 1 AND
        "merchants"."id" = merchant.id ################ NEED TO INSERT MERCHANT ID HERE
      GROUP BY
        invoices.created_at,
        merchants.id
      ORDER BY
        revenue desc,
        invoices.created_at
      LIMIT 1
    SQL
  end

  def enabled?
    enabled
  end

  # TODO: (Scott Borecki) Method not complete.
  def top_day
    invoice_items.select('invoice.created_at', 'SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
                 .joins(:transactions)
                 .where(transactions: { result: :success })
                 .group('invoice.created_at')
                 .order('invoice.created_at, revenue desc')
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
