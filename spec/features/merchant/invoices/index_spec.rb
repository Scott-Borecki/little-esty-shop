require 'rails_helper'

RSpec.describe 'merchant invoices index page' do
  before :each do
    #merchants
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    #items
    @item1 = create(:item, enabled: true, merchant: @merchant1)
    @item2 = create(:item, enabled: true, merchant: @merchant1)
    @item3 = create(:item, enabled: true, merchant: @merchant1)
    @item4 = create(:item, enabled: true, merchant: @merchant2)
    @item5 = create(:item, enabled: true, merchant: @merchant2)

    #customers
    @customer1 = create(:customer)
    @customer2 = create(:customer)

    #invoices
    @invoice1 = create(:invoice, :"in progress", customer: @customer1)
    @invoice2 = create(:invoice, :"in progress", customer: @customer1)
    @invoice3 = create(:invoice, :"in progress", customer: @customer1)
    @invoice4 = create(:invoice, :cancelled, customer: @customer2)
    @invoice5 = create(:invoice, :completed, customer: @customer2)

    #invoice_items
    @invoice_item1 = create(:invoice_item, :pending, invoice: @invoice1, item: @item1)
    @invoice_item2 = create(:invoice_item, :pending, invoice: @invoice2, item: @item2)
    @invoice_item3 = create(:invoice_item, :packaged, invoice: @invoice3, item: @item3)
    @invoice_item4 = create(:invoice_item, :pending, invoice: @invoice4, item: @item1)
    @invoice_item5 = create(:invoice_item, :shipped, invoice: @invoice5, item: @item5)
  end

  it 'displays all invoices that include at least one of my merchants items, each invoice shows its id, and each id links to the merchant invoice show page' do
    # Merchant Invoices Index
    #
    # As a merchant,
    # When I visit my merchant's invoices index (/merchants/merchant_id/invoices)
    # Then I see all of the invoices that include at least one of my merchant's items
    # And for each invoice I see its id
    # And each id links to the merchant invoice show page

    visit "/merchants/#{@merchant1.id}/invoices"

    expect(page).to have_content("Little Esty Shop")
    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content("My Invoices")
    expect(page).to have_content("Invoice ##{@invoice1.id}")
    expect(page).to have_content("Invoice ##{@invoice1.id}")
    expect(page).to have_content("Invoice ##{@invoice2.id}")
    expect(page).to have_content("Invoice ##{@invoice3.id}")
    expect(page).to have_content("Invoice ##{@invoice4.id}")
    expect(page).to_not have_content(@invoice5.id)
  end

  it 'links to the merchant invoice show page' do
    visit "/merchants/#{@merchant1.id}/invoices"

    click_link("##{@invoice1.id}")

    expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
  end
end
