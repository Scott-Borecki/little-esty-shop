require 'rails_helper'

RSpec.describe 'merchant invoices index page' do
  before :each do
    #merchants
    @merchant1 = Merchant.create!(name: 'Dandy')
    @merchant2 = Merchant.create!(name: 'Randy')

    #items
    @item1 = @merchant1.items.create!(name: 'Pogo stick', description: 'Jumpin Stick', unit_price: 100, enabled: true)
    @item2 = @merchant1.items.create!(name: 'Yo - Yo', description: 'Goes and yos', unit_price: 100, enabled: true)
    @item3 = @merchant1.items.create!(name: 'Rollerskates', description: 'Lets roll', unit_price: 100, enabled: true)
    @item4 = @merchant2.items.create!(name: 'Fun Dip', description: 'Dip the fun', unit_price: 100, enabled: true)

    #customers
    @customer1 = Customer.create!(first_name: 'Super', last_name: 'Mario')
    @customer2 = Customer.create!(first_name: 'Donkey', last_name: 'Kong')

    #invoices
    @invoice1 = @customer1.invoices.create!(status: 0)
    @invoice2 = @customer2.invoices.create!(status: 0)
    @invoice3 = @customer2.invoices.create!(status: 1)

    #invoice_items
    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 1000, status: 0)
    @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 10, unit_price: 2000, status: 1)
    @invoice_item3 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice3.id, quantity: 10, unit_price: 100, status: 1)

    visit "/merchants/#{@merchant1.id}/invoices"
  end

  it 'displays all invoices that include at least one of my merchants items, each invoice shows its id, and each id links to the merchant invoice show page' do
    # Merchant Invoices Index
    #
    # As a merchant,
    # When I visit my merchant's invoices index (/merchants/merchant_id/invoices)
    # Then I see all of the invoices that include at least one of my merchant's items
    # And for each invoice I see its id
    # And each id links to the merchant invoice show page

    expect(page).to have_content("Little Esty Shop")
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content("My Invoices")
    expect(page).to have_content("Invoice ##{@invoice1.id}")
    expect(page).to have_content("Invoice ##{@invoice2.id}")
    expect(page).to_not have_content("Invoice ##{@invoice3.id}")
  end

  it 'links to the merchant invoice show page' do
    click_link("##{@invoice1.id}")

    expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
  end
end
