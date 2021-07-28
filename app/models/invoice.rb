class Invoice < ApplicationRecord
  validates :status, presence: true
  enum status: {"in progress": 0, cancelled: 1, completed: 2}
  belongs_to :customer
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
end
