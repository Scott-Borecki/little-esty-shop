require './spec/spec_data_attrs.rb'
module TestData
  # use to create consistent data
  # only need to call the method create_all_data

  def self.create_all_data
    create_merchants
    create_items
    create_customers
    create_invoices
    create_invoice_items
    create_transactions
  end

  def self.create_merchants
    merchant_data.each do |name|
      Merchant.create(name: name[0])
    end

    return "Merchants created"
  end

  def self.create_customers
    customer_data.each do |name|
      Customer.create(first_name: name[0], last_name: name[1])
    end

    return "Customers created"
  end

  def self.create_items
    # attributes = []
    # merch_id_start = Merchant.first.id
    # merch_id_end = Merchant.last.id
    # 12.times do
    #   attributes << [Faker::Movies::HarryPotter.character, Faker::TvShows::BojackHorseman.quote, rand(100..10000), rand(0..1).round, rand(merch_id_start..merch_id_end)]
    # end
    item_data.each do |item_attr|
      Item.create!(
        name: item_attr[0],
        description: item_attr[1],
        unit_price: item_attr[2],
        merchant_id: item_attr[4]
      )
    end

    return "Items created"
  end

  def self.create_invoices
    i = 0
    # 25.times do
    #   attributes << rand(0..2)
    # end
    Customer.all.each do |customer|
      4.times do
        customer.invoices.create(status: invoice_data[i])
        i += 1
      end
    end

    return "Invoices created"
  end

  def self.create_invoice_items
    items = Item.all
    i = 0
    j = 0
    Invoice.all.each do |invoice|
      k = 0
      3.times do
        invoice.invoice_items.create!(
          quantity: invoice_item_data[j][0],
          unit_price: (i + k >= 19) ? items[i - k].unit_price : items[i + k].unit_price,
          status: invoice_item_data[j][2],
          item_id:( i + k >= 19) ? items[i - k].id : items[i + k].id
        )
        j += 1
        k += 1
      end
      i += 1
    end

    return "Invoice Items created"
  end

  def self.create_transactions
    i = 0
    Invoice.all.each do |invoice|
      invoice.transactions.create!(
        credit_card_number: transaction_data[i][0].delete('-')[0..15],
        result: transaction_data[i][1]
      )
      i += 1
    end

    return "Transactions created"
  end
end
