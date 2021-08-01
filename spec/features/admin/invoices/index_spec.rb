require 'rails_helper'
require_relative '../../../spec_data.rb'

RSpec.describe 'Admin invoice Index page' do
  # As an admin,
  # When I visit the admin Invoices index ("/admin/invoices")
  # Then I see a list of all Invoice ids in the system
  # Each id links to the admin invoice show page
  before(:each) do
    TestData.invoices
    visit '/admin/invoices'
  end

  it 'has a list of all invoice ids and each is a link to the /admin/invoices/:id' do
    expect(page).to have_content(Invoice.first.id)
    expect(page).to have_content(Invoice.last.id)
    click_on(Invoice.last.id)
    expect(current_path).to eq("/admin/invoices/#{Invoice.last.id}")
  end
end
