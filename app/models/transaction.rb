class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true, numericality: true, length: { in: 15..16 }
  validates :credit_card_expiration_date, presence: true, numericality: true
  validates :result, presence: true, numericality: true

  belongs_to :invoice
end
