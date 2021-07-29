require 'rails_helper'
require_relative '../../../spec_data.rb'

RSpec.describe 'Admin invoice Show page' do
  before(:each) do  
    TestData.invoices
    visit "/admin/invoices/#{Invoice.first.id}"
  end
  # As an admin,
  # When I visit an admin invoice show page
  # Then I see information related to that invoice including:
  # - Invoice id
  # - Invoice status
  # - Invoice created_at date in the format "Monday, July 18, 2019"
  # - Customer first and last name
  it 'has the invoices attributes' do
    expect(page).to have_content(Invoice.first.id)
    expect(page).to have_content(Invoice.first.status)
    expect(page).to have_content(Invoice.first.created_at)
    expect(page).to have_content(Invoice.first.customer.first_name)
    expect(page).to have_content(Invoice.first.customer.last_name)
  end

  # Admin Invoice Show Page: Invoice Item Information

  # As an admin
  # When I visit an admin invoice show page
  # Then I see all of the items on the invoice including:
  # - Item name
  # - The quantity of the item ordered
  # - The price the Item sold for
  # - The Invoice Item status

  # Admin Invoice Show Page: Total Revenue

  # As an admin
  # When I visit an admin invoice show page
  # Then I see the total revenue that will be generated from this invoice

  # Admin Invoice Show Page: Update Invoice Status

  # As an admin     
  # When I visit an admin invoice show page
  # I see the invoice status is a select field
  # And I see that the invoice's current status is selected
  # When I click this select field,
  # Then I can select a new status for the Invoice,
  # And next to the select field I see a button to "Update Invoice Status"
  # When I click this button
  # I am taken back to the admin invoice show page
  # And I see that my Invoice's status has now been updated
end