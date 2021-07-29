class Merchant < ApplicationRecord
  has_many :items

  validates :name, presence: true
  validates :enabled, inclusion: { in: [true, false] }

  def self.enabled_merchants
    where(enabled: true)
  end

  def self.disabled_merchants
    where(enabled: false)
  end

  def enabled?
    enabled
  end
end
