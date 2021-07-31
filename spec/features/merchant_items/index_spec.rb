require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, enabled: true, merchant: @merchant_1)
    @item_2 = create(:item, enabled: true, merchant: @merchant_1)
    @item_3 = create(:item, enabled: true, merchant: @merchant_1)
    @item_4 = create(:item, enabled: true, merchant: @merchant_2)

    visit merchant_items_path(@merchant_1)
  end

  it 'can list all of the items for a merchant' do
    expect(page).to have_content("#{@merchant_1.name}'s Items")
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_3.name)
    expect(page).to_not have_content(@merchant_2.name)
    expect(page).to_not have_content(@item_4.name)
  end

  it 'has a button next to each item name to disable or enable that item' do
    within "#item-#{@item_1.id}" do
      expect(@item_1.enabled).to eq(true)
      expect(page).to_not have_button('Enable')
      expect(page).to have_button('Disable')

      click_on "Disable"

      expect(current_path).to eq(merchant_items_path(@merchant_1))
      expect(@item_1.reload.enabled).to eq(false)
      expect(page).to have_button('Enable')
      expect(page).to_not have_button('Disable')

      click_on "Enable"

      expect(current_path).to eq(merchant_items_path(@merchant_1))
      expect(@item_1.reload.enabled).to eq(true)
      expect(page).to_not have_button('Enable')
      expect(page).to have_button('Disable')
    end

    within "#item-#{@item_2.id}" do
      expect(page).to_not have_button('Enable')
      expect(page).to have_button('Disable')
    end

    within "#item-#{@item_3.id}" do
      expect(page).to_not have_button('Enable')
      expect(page).to have_button('Disable')
    end
  end
end
