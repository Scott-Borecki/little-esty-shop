class Item < ApplicationRecord
  validates :name, :description, :unit_price, :enabled, presence: true

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end
