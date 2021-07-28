class Invoice < ApplicationRecord
  validates :status, presence: true

  belongs_to :customer
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
end
