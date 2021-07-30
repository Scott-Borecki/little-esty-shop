FactoryBot.define do
  # Customer
  factory :customer do
    first_name { Faker::Movies::HarryPotter.spell }
    last_name  { Faker::Movies::HarryPotter.house }
    #
    # factory :customer_with_invoices do
    #   after(:create) do |customer, evaluator|
    #     create_list(:invoice, evaluator.invoice_count, customer: customer)
    #   end
    # end
  end

  # Invoice
  factory :invoice do
    customer
  end

  factory :invoice_item do
    quantity { rand(1..10) }
    unit_price { rand(1_000..2_000) }
    item
    invoice
  end

  # Item
  factory :item do
    name { Faker::Book.title }
    description { Faker::Company.buzzword }
    unit_price { rand(1_000..2_000) }
    merchant
  end

  # Merchants
  factory :merchant do
    name { Faker::Company.name }

    factory :enabled_merchant do
      enabled { true }
    #
    #   factory :merchant_with_revenue_generated do
    #     transient do
    #       items_count { 5 }
    #     end
    #
    #     after(:create) do |merchant, evaluator|
    #       create_list(:item, evaluator.items_count, merchant: merchant)
    #       # merchant.reload
    #     end
    #   end
    end

    factory :disabled_merchant do
      enabled { false }
    end
  end

  # Transaction
  factory :transaction do
    credit_card_number { Faker::Business.credit_card_number.delete('-') }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    invoice
  end
end

def customer_with_in_progress_invoices(invoice_count: 5)
  FactoryBot.create(:customer) do |customer|
    FactoryBot.create_list(:invoice, invoice_count, {
      status: :"in progress", customer: customer
      })
  end
end

def customer_with_cancelled_invoices(invoice_count: 5)
  FactoryBot.create(:customer) do |customer|
    FactoryBot.create_list(:invoice, invoice_count, {
      status: :cancelled, customer: customer
      })
  end
end

def customer_with_completed_invoices(invoice_count: 5)
  FactoryBot.create(:customer) do |customer|
    FactoryBot.create_list(:invoice, invoice_count, {
      status: :completed, customer: customer
      })
  end
end
