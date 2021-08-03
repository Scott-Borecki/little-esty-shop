FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.first_name }
  end

  factory :invoice do
    customer
    traits_for_enum(:status)
  end

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

def create_factories_merchant_dashboard
  let!(:customer1) { create(:customer) }
  let!(:customer2) { create(:customer) }
  let!(:customer3) { create(:customer) }
  let!(:customer4) { create(:customer) }
  let!(:customer5) { create(:customer) }
  let!(:customer6) { create(:customer) }
  let!(:customer7) { create(:customer) }
  let!(:customer8) { create(:customer) }
  let!(:customer9) { create(:customer) }
  let!(:customer10) { create(:customer) }

  let!(:merchant1) { create(:enabled_merchant) }

  let!(:item1) { create(:item, merchant: merchant1) }
  let!(:item2) { create(:item, merchant: merchant1) }
  let!(:item3) { create(:item, merchant: merchant1) }
  let!(:item4) { create(:item, merchant: merchant1) }
  let!(:item5) { create(:item, merchant: merchant1) }
  let!(:item6) { create(:item, merchant: merchant1) }
  let!(:item7) { create(:item, merchant: merchant1) }
  let!(:item8) { create(:item, merchant: merchant1) }
  let!(:item9) { create(:item, merchant: merchant1) }
  let!(:item10) { create(:item, merchant: merchant1) }
  let!(:item11) { create(:item, merchant: merchant1) }
  let!(:item12) { create(:item, merchant: merchant1) }
  let!(:item13) { create(:item, merchant: merchant1) }
  let!(:item14) { create(:item, merchant: merchant1) }
  let!(:item15) { create(:item, merchant: merchant1) }
  let!(:item16) { create(:item, merchant: merchant1) }
  let!(:item17) { create(:item, merchant: merchant1) }
  let!(:item18) { create(:item, merchant: merchant1) }
  let!(:item19) { create(:item, merchant: merchant1) }
  let!(:item20) { create(:item, merchant: merchant1) }

  let!(:invoice1) { create(:invoice, :completed, customer: customer1) }
  let!(:invoice2) { create(:invoice, :completed, customer: customer1) }
  let!(:invoice3) { create(:invoice, :completed, customer: customer2) }
  let!(:invoice4) { create(:invoice, :completed, customer: customer2) }
  let!(:invoice5) { create(:invoice, :completed, customer: customer2) }
  let!(:invoice6) { create(:invoice, :completed, customer: customer3) }
  let!(:invoice7) { create(:invoice, :completed, customer: customer3) }
  let!(:invoice8) { create(:invoice, :completed, customer: customer3) }
  let!(:invoice9) { create(:invoice, :completed, customer: customer3) }
  let!(:invoice10) { create(:invoice, :completed, customer: customer4) }
  let!(:invoice11) { create(:invoice, :completed, customer: customer4) }
  let!(:invoice12) { create(:invoice, :completed, customer: customer4) }
  let!(:invoice13) { create(:invoice, :completed, customer: customer5) }
  let!(:invoice14) { create(:invoice, :completed, customer: customer6) }
  let!(:invoice15) { create(:invoice, :completed, customer: customer7) }
  let!(:invoice16) { create(:invoice, :completed, customer: customer7) }
  let!(:invoice17) { create(:invoice, :completed, customer: customer8) }
  let!(:invoice18) { create(:invoice, :completed, customer: customer8) }
  let!(:invoice19) { create(:invoice, :completed, customer: customer9) }
  let!(:invoice20) { create(:invoice, :completed, customer: customer10) }

  let!(:transaction1) { create(:transaction, :failed, invoice: invoice1) }
  let!(:transaction2) { create(:transaction, :success, invoice: invoice2) }
  let!(:transaction3) { create(:transaction, :success, invoice: invoice3) }
  let!(:transaction4) { create(:transaction, :success, invoice: invoice4) }
  let!(:transaction5) { create(:transaction, :success, invoice: invoice5) }
  let!(:transaction6) { create(:transaction, :success, invoice: invoice6) }
  let!(:transaction7) { create(:transaction, :success, invoice: invoice7) }
  let!(:transaction8) { create(:transaction, :success, invoice: invoice8) }
  let!(:transaction9) { create(:transaction, :success, invoice: invoice9) }
  let!(:transaction10) { create(:transaction, :success, invoice: invoice10) }
  let!(:transaction11) { create(:transaction, :success, invoice: invoice11) }
  let!(:transaction12) { create(:transaction, :success, invoice: invoice12) }
  let!(:transaction13) { create(:transaction, :success, invoice: invoice13) }
  let!(:transaction14) { create(:transaction, :success, invoice: invoice14) }
  let!(:transaction15) { create(:transaction, :success, invoice: invoice15) }
  let!(:transaction16) { create(:transaction, :success, invoice: invoice16) }
  let!(:transaction17) { create(:transaction, :success, invoice: invoice17) }
  let!(:transaction18) { create(:transaction, :success, invoice: invoice18) }
  let!(:transaction19) { create(:transaction, :success, invoice: invoice19) }
  let!(:transaction20) { create(:transaction, :success, invoice: invoice20) }

  let!(:invoice_item1a) { create(:invoice_item, :pending, item: item1, invoice: invoice1, quantity: 2, unit_price: 10) }
  let!(:invoice_item1b) { create(:invoice_item, :pending, item: item1, invoice: invoice1, quantity: 5, unit_price: 20) }
  let!(:invoice_item2a) { create(:invoice_item, :pending, item: item2, invoice: invoice2, quantity: 4, unit_price: 10) }
  let!(:invoice_item2b) { create(:invoice_item, :pending, item: item2, invoice: invoice2, quantity: 5, unit_price: 20) }
  let!(:invoice_item3a) { create(:invoice_item, :pending, item: item3, invoice: invoice3, quantity: 1, unit_price: 10) }
  let!(:invoice_item3b) { create(:invoice_item, :pending, item: item3, invoice: invoice3, quantity: 5, unit_price: 20) }
  let!(:invoice_item4a) { create(:invoice_item, :shipped, item: item4, invoice: invoice4, quantity: 3, unit_price: 10) }
  let!(:invoice_item4b) { create(:invoice_item, :shipped, item: item4, invoice: invoice4, quantity: 5, unit_price: 20) }
  let!(:invoice_item5a) { create(:invoice_item, :shipped, item: item5, invoice: invoice5, quantity: 5, unit_price: 10) }
  let!(:invoice_item5b) { create(:invoice_item, :shipped, item: item5, invoice: invoice5, quantity: 5, unit_price: 20) }
  let!(:invoice_item6a) { create(:invoice_item, :shipped, item: item6, invoice: invoice6, quantity: 6, unit_price: 10) }
  let!(:invoice_item6b) { create(:invoice_item, :shipped, item: item6, invoice: invoice6, quantity: 5, unit_price: 20) }
  let!(:invoice_item7a) { create(:invoice_item, :packaged, item: item7, invoice: invoice7, quantity: 2, unit_price: 10) }
  let!(:invoice_item7b) { create(:invoice_item, :packaged, item: item7, invoice: invoice7, quantity: 5, unit_price: 20) }
  let!(:invoice_item8a) { create(:invoice_item, :packaged, item: item8, invoice: invoice8, quantity: 4, unit_price: 10) }
  let!(:invoice_item8b) { create(:invoice_item, :packaged, item: item8, invoice: invoice8, quantity: 5, unit_price: 20) }
  let!(:invoice_item9a) { create(:invoice_item, :packaged, item: item9, invoice: invoice9, quantity: 1, unit_price: 10) }
  let!(:invoice_item9b) { create(:invoice_item, :packaged, item: item9, invoice: invoice9, quantity: 5, unit_price: 20) }
  let!(:invoice_item10a) { create(:invoice_item, :shipped, item: item10, invoice: invoice10, quantity: 3, unit_price: 10) }
  let!(:invoice_item10b) { create(:invoice_item, :shipped, item: item10, invoice: invoice10, quantity: 5, unit_price: 20) }
  let!(:invoice_item11a) { create(:invoice_item, :shipped, item: item11, invoice: invoice11, quantity: 5, unit_price: 10) }
  let!(:invoice_item11b) { create(:invoice_item, :packaged, item: item11, invoice: invoice11, quantity: 5, unit_price: 20) }
  let!(:invoice_item12a) { create(:invoice_item, :packaged, item: item12, invoice: invoice12, quantity: 6, unit_price: 10) }
  let!(:invoice_item12b) { create(:invoice_item, :packaged, item: item12, invoice: invoice12, quantity: 5, unit_price: 20) }
  let!(:invoice_item13a) { create(:invoice_item, :packaged, item: item13, invoice: invoice13, quantity: 6, unit_price: 10) }
  let!(:invoice_item13b) { create(:invoice_item, :packaged, item: item13, invoice: invoice13, quantity: 5, unit_price: 20) }
  let!(:invoice_item14a) { create(:invoice_item, :packaged, item: item14, invoice: invoice14, quantity: 6, unit_price: 10) }
  let!(:invoice_item14b) { create(:invoice_item, :packaged, item: item14, invoice: invoice14, quantity: 5, unit_price: 20) }
  let!(:invoice_item15a) { create(:invoice_item, :packaged, item: item15, invoice: invoice15, quantity: 6, unit_price: 10) }
  let!(:invoice_item15b) { create(:invoice_item, :packaged, item: item15, invoice: invoice15, quantity: 5, unit_price: 20) }
  let!(:invoice_item16a) { create(:invoice_item, :pending, item: item16, invoice: invoice16, quantity: 6, unit_price: 10) }
  let!(:invoice_item16b) { create(:invoice_item, :pending, item: item16, invoice: invoice16, quantity: 5, unit_price: 20) }
  let!(:invoice_item17a) { create(:invoice_item, :pending, item: item17, invoice: invoice17, quantity: 6, unit_price: 10) }
  let!(:invoice_item17b) { create(:invoice_item, :pending, item: item17, invoice: invoice17, quantity: 5, unit_price: 20) }
  let!(:invoice_item18a) { create(:invoice_item, :pending, item: item18, invoice: invoice18, quantity: 6, unit_price: 10) }
  let!(:invoice_item18b) { create(:invoice_item, :pending, item: item18, invoice: invoice18, quantity: 5, unit_price: 20) }
  let!(:invoice_item19a) { create(:invoice_item, :pending, item: item19, invoice: invoice19, quantity: 6, unit_price: 10) }
  let!(:invoice_item19b) { create(:invoice_item, :pending, item: item19, invoice: invoice19, quantity: 5, unit_price: 20) }
  let!(:invoice_item20a) { create(:invoice_item, :pending, item: item20, invoice: invoice20, quantity: 6, unit_price: 10) }
  let!(:invoice_item20b) { create(:invoice_item, :pending, item: item20, invoice: invoice20, quantity: 5, unit_price: 20) }
end
