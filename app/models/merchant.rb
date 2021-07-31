class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoice_items, through: :items
  # has_many :invoices, through: :invoice_items
  # has_many :customers, through: :invoices
  # has_many :transactions, through: :invoices

  # AR joins temp tables
  # calulations: that you want to know, not to save
  # relationship: want to save
end
