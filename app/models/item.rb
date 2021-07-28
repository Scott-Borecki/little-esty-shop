class Item < ApplicationRecord
  validates :name, :description, :enabled, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :enabled, inclusion: { in: [true, false] }

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end
