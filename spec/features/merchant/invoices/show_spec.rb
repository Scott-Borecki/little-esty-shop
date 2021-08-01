require 'rails_helper'

RSpec.describe 'merchant invoices show page' do
  before :each do
    # merchants
    @merchant1 = Merchant.create!(name: 'Dandy')
    @merchant2 = Merchant.create!(name: 'Randy')

    # items
    @item1 = @merchant1.items.create!(name: 'Pogo stick', description: 'Jumpin Stick', unit_price: 100, enabled: true)
    @item2 = @merchant1.items.create!(name: 'Yo - Yo', description: 'Goes and yos', unit_price: 100, enabled: true)
    @item3 = @merchant1.items.create!(name: 'Rollerskates', description: 'Lets roll', unit_price: 100, enabled: true)
    @item4 = @merchant2.items.create!(name: 'Fun Dip', description: 'Dip the fun', unit_price: 100, enabled: true)

    # customers
    @customer1 = Customer.create!(first_name: 'Super', last_name: 'Mario')
    @customer2 = Customer.create!(first_name: 'Donkey', last_name: 'Kong')

    # invoices
    @invoice1 = @customer1.invoices.create!(status: 0)
    @invoice2 = @customer2.invoices.create!(status: 0)

    # invoice_items
    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 1111, status: 0)
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 2022, status: 1)
    @invoice_item3 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice2.id, quantity: 10, unit_price: 101, status: 1)

    visit("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
  end

  it 'displays the merchant invoice show page and its attributes' do
    # Merchant Invoice Show Page
    #
    # As a merchant
    # When I visit my merchant's invoice show page(/merchants/merchant_id/invoices/invoice_id)
    # Then I see information related to that invoice including:
    # - Invoice id
    # - Invoice status
    # - Invoice created_at date in the format "Monday, July 18, 2019"
    # - Customer first and last name

    expect(page).to have_content('Little Esty Shop')
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content("Invoice ##{@invoice1.id}")
    # do we need to change lower case 'in progress' to 'In Progress' here?
    expect(page).to have_content("Status: #{@invoice1.status}")
    expect(page).to have_content("Created on: #{@invoice1.created_at.strftime('%A, %B %-d, %Y')}")
    expect(page).to have_content('Customer:')
    expect(page).to have_content("#{@customer1.first_name} #{@customer1.last_name}")
  end

  it 'displays all invoice items and their attributes' do
    # Merchant Invoice Show Page: Invoice Item Information
    #
    # As a merchant
    # When I visit my merchant invoice show page
    # Then I see all of my items on the invoice including:
    # - Item name
    # - The quantity of the item ordered
    # - The price the Item sold for
    # - The Invoice Item status
    # And I do not see any information related to Items for other merchants

    within("#item_#{@invoice_item1.id}") do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@invoice_item1.quantity)
      expect(page).to have_content(@invoice_item1.unit_price / 100.00)
      expect(page).to have_content(@invoice_item1.status)
    end

    within("#item_#{@invoice_item2.id}") do
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@invoice_item2.quantity)
      expect(page).to have_content(@invoice_item2.unit_price / 100.00)
      expect(page).to have_content(@invoice_item2.status)
    end

    expect(page).to_not have_content(@item3.name)
  end

  it 'displays the total revenue that will be generated from all my items on the invoice' do
    # Merchant Invoice Show Page: Total Revenue
    #
    # As a merchant
    # When I visit my merchant invoice show page
    # Then I see the total revenue that will be generated from all of my items on the invoice

    expect(page).to have_content('$151.54')
  end
end
