class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :enabled, inclusion: { in: [true, false] }

  def self.all_enabled
    where('enabled = true')
  end

  def self.all_disabled
    where('enabled = false')
  end
end
