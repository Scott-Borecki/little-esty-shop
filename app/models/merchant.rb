class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items

  def self.enabled_merchants
    where(enabled: true)
  end

  def enabled?
    enabled
  end
end
