require 'rails_helper'

RSpec.describe 'merchant dashboard index page' do
  create_factories_merchant_dashboard

  it 'displays the merchant name' do
    # Merchant Dashboard
    #
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
    # Then I see the name of my merchant

    visit("/merchants/#{merchant1.id}/dashboard")

    expect(page).to have_content(merchant1.name)
  end

  it 'has a link to merchants items index' do
    # Merchant Dashboard Links
    #
    # As a merchant,
    # When I visit my merchant dashboard
    # Then I see link to my merchant items index (/merchants/merchant_id/items)
    # And I see a link to my merchant invoices index (/merchants/merchant_id/invoices)

    visit("/merchants/#{merchant1.id}/dashboard")

    expect(page).to have_link('My Items')

    click_link('My Items')

    expect(current_path).to eq("/merchants/#{merchant1.id}/items")
  end

  it 'has a link to merchants invoices index' do
    visit("/merchants/#{merchant1.id}/dashboard")

    expect(page).to have_link('My Invoices')

    click_link('My Invoices')

    expect(current_path).to eq("/merchants/#{merchant1.id}/invoices")
  end

  it 'displays the top 5 customers' do
    # Merchant Dashboard Statistics - Favorite Customers
    #
    # As a merchant,
    # When I visit my merchant dashboard
    # Then I see the names of the top 5 customers
    # who have conducted the largest number of successful transactions with my merchant
    # And next to each customer name I see the number of successful transactions they have
    # conducted with my merchant

    visit("/merchants/#{merchant1.id}/dashboard")

    expect(page).to have_content(customer3.first_name)
    expect(page).to have_content(customer2.first_name)
    expect(page).to have_content(customer4.first_name)
    expect(page).to have_content(customer7.first_name)
    expect(page).to have_content(customer8.first_name)
    expect(page).to have_no_content(customer1.first_name)
    expect(page).to have_no_content(customer5.first_name)
    expect(page).to have_no_content(customer6.first_name)
    expect(page).to have_no_content(customer9.first_name)
    expect(page).to have_no_content(customer10.first_name)
  end

  it 'displays the number of successful transactions next to each top customer' do

  end

  describe 'Merchant Dashboard Items Ready to Ship' do
    it 'displays items ready to ship' do
      visit("/merchants/#{merchant1.id}/dashboard")

      expect(page).to have_content('Items Ready to Ship')

      within "#invoice-items-ready-to-ship" do
        expect(page).to have_content(item4.name)
        expect(page).to have_content(item5.name)
        expect(page).to have_content(item6.name)
        expect(page).to have_content(item10.name)
        expect(page).to have_content(item11.name)
      end
    end

    it 'displays the invoice id next to each item as a link' do
      visit("/merchants/#{merchant1.id}/dashboard")

      within "#ii-ready-to-ship-#{invoice_item4a.id}" do
        expect(page).to have_content(invoice4.id)

        click_on "#{invoice4.id}"

        expect(current_path).to eq("/merchants/#{merchant1.id}/invoices/#{invoice4.id}")
        expect(current_path).to eq(merchant_invoice_path(merchant1.id, invoice4.id))
      end
    end

    it 'displays the invoice created at date for each item' do
      visit("/merchants/#{merchant1.id}/dashboard")

      within "#ii-ready-to-ship-#{invoice_item6a.id}" do
        expect(page).to have_content(invoice6.formatted_time)
      end
    end

    it 'display the invoice items from oldest to newest' do
      visit("/merchants/#{merchant1.id}/dashboard")

      within "#invoice-items-ready-to-ship" do
        expect(invoice_item11a.item.name).to appear_before(invoice_item10b.item.name)
        expect(invoice_item10a.item.name).to appear_before(invoice_item5b.item.name)
      end
    end
  end
end
