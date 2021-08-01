FactoryBot.define do
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

  factory :invoice do
    customer
    traits_for_enum(:status)
  end

#   factory :item do
#     name { Faker::Movies::Lebowski.character }
#     description { Faker::Movies::Lebowski.quote }
#     unit_price { rand(10_000) }
#     merchant
#   end
  
  factory :item do
    name { Faker::Movies::HarryPotter.location }
    description { Faker::Movies::LordOfTheRings.location }
    unit_price { Faker::Number.binary(digits: 5) }
    enabled { Faker::Boolean.boolean }
    merchant
  end

  factory :invoice_item do
    quantity { rand(20) }
    unit_price { rand(10_000) }
    invoice
    item
    traits_for_enum(:status)
  end
  
#   factory :invoice_item do
#     quantity { rand(1..10) }
#     unit_price { rand(1_000..2_000) }
#     item
#     invoice
#   end

  factory :merchant do
    name { Faker::Movies::HarryPotter.character }

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

  factory :transaction do
    credit_card_number { Faker::Business.credit_card_number.delete('-') }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    invoice
  end
end

def create_factories
  let!(:customer) { create(:customer) }

  let!(:merchant1) { create(:enabled_merchant) }
  let!(:merchant2) { create(:enabled_merchant) }
  let!(:merchant3) { create(:enabled_merchant) }
  let!(:merchant4) { create(:disabled_merchant) }
  let!(:merchant5) { create(:disabled_merchant) }
  let!(:merchant6) { create(:enabled_merchant) }

  let!(:item1) { create(:item, merchant: merchant1) }
  let!(:item2) { create(:item, merchant: merchant2) }
  let!(:item3) { create(:item, merchant: merchant3) }
  let!(:item4) { create(:item, merchant: merchant4) }
  let!(:item5) { create(:item, merchant: merchant5) }
  let!(:item6) { create(:item, merchant: merchant6) }

  let!(:invoice1) { create(:invoice, :completed, customer: customer) }
  let!(:invoice2) { create(:invoice, :completed, customer: customer) }
  let!(:invoice3) { create(:invoice, :completed, customer: customer) }
  let!(:invoice4) { create(:invoice, :completed, customer: customer) }
  let!(:invoice5) { create(:invoice, :completed, customer: customer) }
  let!(:invoice6) { create(:invoice, :completed, customer: customer) }

  let!(:transaction1) { create(:transaction, :failed, invoice: invoice1) }
  let!(:transaction2) { create(:transaction, :success, invoice: invoice2) }
  let!(:transaction3) { create(:transaction, :success, invoice: invoice3) }
  let!(:transaction4) { create(:transaction, :success, invoice: invoice4) }
  let!(:transaction5) { create(:transaction, :success, invoice: invoice5) }
  let!(:transaction6) { create(:transaction, :success, invoice: invoice6) }

  let!(:invoice_item1a) { create(:invoice_item, :shipped, item: item1, invoice: invoice1, quantity: 2, unit_price: 10) }
  let!(:invoice_item1b) { create(:invoice_item, :shipped, item: item1, invoice: invoice1, quantity: 5, unit_price: 20) }
  let!(:invoice_item2a) { create(:invoice_item, :shipped, item: item2, invoice: invoice2, quantity: 4, unit_price: 10) }
  let!(:invoice_item2b) { create(:invoice_item, :shipped, item: item2, invoice: invoice2, quantity: 5, unit_price: 20) }
  let!(:invoice_item3a) { create(:invoice_item, :shipped, item: item3, invoice: invoice3, quantity: 1, unit_price: 10) }
  let!(:invoice_item3b) { create(:invoice_item, :shipped, item: item3, invoice: invoice3, quantity: 5, unit_price: 20) }
  let!(:invoice_item4a) { create(:invoice_item, :shipped, item: item4, invoice: invoice4, quantity: 3, unit_price: 10) }
  let!(:invoice_item4b) { create(:invoice_item, :shipped, item: item4, invoice: invoice4, quantity: 5, unit_price: 20) }
  let!(:invoice_item5a) { create(:invoice_item, :shipped, item: item5, invoice: invoice5, quantity: 5, unit_price: 10) }
  let!(:invoice_item5b) { create(:invoice_item, :shipped, item: item5, invoice: invoice5, quantity: 5, unit_price: 20) }
  let!(:invoice_item6a) { create(:invoice_item, :shipped, item: item6, invoice: invoice6, quantity: 6, unit_price: 10) }
  let!(:invoice_item6b) { create(:invoice_item, :shipped, item: item6, invoice: invoice6, quantity: 5, unit_price: 20) }
end


# TODO: Are we using these methods?  Can we delete?
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
