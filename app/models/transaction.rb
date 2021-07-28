class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true, numericality: true, length: { in: 15..16 }
  validates :result, presence: true
  enum result: {failed: 0, success: 1 }
  belongs_to :invoice
end
