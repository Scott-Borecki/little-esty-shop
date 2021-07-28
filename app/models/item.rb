class Item < ApplicationRecord
  validates :name, :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :enabled, presence: true, inclusion: { in: [true, false] }

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end
