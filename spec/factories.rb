FactoryBot.define do
  factory :customer do
    first_name { Faker::Movies::HarryPotter.unique.spell }
    last_name  { Faker::Movies::HarryPotter.unique.house }
    end

  factory :invoice do
    customer
  end

  factory :merchant do
    name { Faker::Movies::HarryPotter.unique.character }
  end

  factory :item do
    name { Faker::Movies::HarryPotter.spell }
    description { Faker::Movies::HarryPotter.unique.quote }
    unit_price { Faker::Number.binary(digits:5) }
    enabled { Faker::Boolean.boolean }
    merchant
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
