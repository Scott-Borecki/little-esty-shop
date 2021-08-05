require 'rails_helper'
require_relative '../../../create_test_objects.rb'

RSpec.describe 'Admin invoice Index page' do
  before(:each) do
    Merchant.destroy_all
    Customer.destroy_all
    TestData.create_all_data

    visit '/admin/invoices'
  end

  it 'has a list of all invoice ids and each is a link to the /admin/invoices/:id' do
    expect(page).to have_content("#{Invoice.first.id}")
    expect(page).to have_content(Invoice.last.id)

    click_on Invoice.last.id.to_s

    expect(current_path).to eq("/admin/invoices/#{Invoice.last.id}")
  end
end
