require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @item1 = create(:item, enabled: true, merchant: @merchant1)
    @item2 = create(:item, enabled: true, merchant: @merchant1)
    @item3 = create(:item, enabled: false, merchant: @merchant1)
    @item4 = create(:item, enabled: true, merchant: @merchant2)
    @item5 = create(:item, enabled: false, merchant: @merchant2)

    visit merchant_items_path(@merchant1)
  end

  it 'can list all of the items for a merchant' do
    expect(page).to have_content("#{@merchant1.name}'s Items")
    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)
    expect(page).to have_content(@item3.name)
    expect(page).to_not have_content(@merchant2.name)
    expect(page).to_not have_content(@item4.name)
    expect(page).to_not have_content(@item5.name)
  end

  it 'has a button next to each item name to disable OR enable that item' do
    within "#item-#{@item1.id}" do
      expect(@item1.enabled).to eq(true)
      expect(page).to_not have_button('Enable')
      expect(page).to have_button('Disable')

      click_on 'Disable'

      expect(current_path).to eq(merchant_items_path(@merchant1))
      expect(@item1.reload.enabled).to eq(false)
      expect(page).to have_button('Enable')
      expect(page).to_not have_button('Disable')

      click_on 'Enable'

      expect(current_path).to eq(merchant_items_path(@merchant1))
      expect(@item1.reload.enabled).to eq(true)
      expect(page).to_not have_button('Enable')
      expect(page).to have_button('Disable')
    end

    within "#item-#{@item2.id}" do
      expect(page).to_not have_button('Enable')
      expect(page).to have_button('Disable')
    end

    within "#item-#{@item3.id}" do
      expect(page).to have_button('Enable')
      expect(page).to_not have_button('Disable')
    end
  end

  it 'has two sections: one for enabled items and one for disabled items' do
    within '#all-enabled' do
      expect(page).to have_content('Enabled Items')
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to_not have_content(@item3.name)
    end

    within '#all-disabled' do
      expect(page).to have_content('Disabled Items')
      expect(page).to_not have_content(@item1.name)
      expect(page).to_not have_content(@item2.name)
      expect(page).to have_content(@item3.name)
    end
  end
end
