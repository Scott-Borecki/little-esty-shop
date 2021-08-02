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

end
