class Transaction < ApplicationRecord
  enum result: { failed: 0, success: 1 }

  belongs_to :invoice

  validates :credit_card_number, presence: true,
                                 numericality: true,
                                 length: { in: 15..16 }
  validates :result, presence: true, numericality: true

  def self.successful_transactions
    where(result: :success)
  end
end
