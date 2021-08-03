class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.top_customers(merchant_id)
    select('count(customers.id) as total_transactions, customers.*')
    .joins(invoices: :transactions)
    .joins(invoices: :items)
    .where('transactions.result = 1')
    .where('items.merchant_id = ?', merchant_id)
    .group(:id)
    .order('total_transactions desc')
    .limit(5)
  end
end
