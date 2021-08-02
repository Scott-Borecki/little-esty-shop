require 'rails_helper'

RSpec.describe 'merchant dashboard index page' do
  create_factories

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
end
