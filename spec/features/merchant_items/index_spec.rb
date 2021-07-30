require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, enabled: true, merchant: @merchant_1)
    @item_2 = create(:item, enabled: true, merchant: @merchant_1)
    @item_3 = create(:item, enabled: true, merchant: @merchant_1)
    @item_4 = create(:item, enabled: true, merchant: @merchant_2)
    @item_5 = create(:item, enabled: true, merchant: @merchant_2)

    # visit "/merchants/#{@merchant_1.id}/items"
    visit merchant_items_path(@merchant_1)
  end

  it 'can list all of the items for a merchant' do
    expect(page).to have_content("#{@merchant_1.name}'s Items")
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_3.name)
    expect(page).to_not have_content(@merchant_2.name)
    expect(page).to_not have_content(@item_4.name)
    expect(page).to_not have_content(@item_5.name)
  end

  it 'has a button next to each item name to disable or enable that item' do
    within "#item-#{@item_1.id}" do
      expect(page).to have_selector(:link_or_button, 'Enable')
      expect(page).to have_selector(:link_or_button, 'Disable')
    end

    within "#item-#{@item_2.id}" do
      expect(page).to have_selector(:link_or_button, 'Enable')
      expect(page).to have_selector(:link_or_button, 'Disable')
    end

    within "#item-#{@item_3.id}" do
      expect(page).to have_selector(:link_or_button, 'Enable')
      expect(page).to have_selector(:link_or_button, 'Disable')
    end
save_and_open_page  
    # When I click this button
    # Then I am redirected back to the items index
    # And I see that the items status has changed
  end
end
