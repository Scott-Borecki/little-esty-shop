FactoryBot.define do
  factory :customer do
    first_name { Faker::Movies::HarryPotter.unique.spell }
    last_name  { Faker::Movies::HarryPotter.unique.house }
  end

  factory :invoice do
    customer
  end

  # Merchants
  factory :merchant do
    name { Faker::Company.name }

    factory :enabled_merchant do
      enabled { true }
    end

    factory :disabled_merchant do
      enabled { false }
    end
  end
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
