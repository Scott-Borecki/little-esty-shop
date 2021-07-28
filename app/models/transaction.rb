class Transaction < ApplicationRecord
  validates :credit_card_number, :credit_card_expiration_date, :result, presence: true, numericality: true

  belongs_to :invoice
end
