require 'rails_helper'

RSpec.describe 'create merchant item page' do
  before :each do
    @merchant_1 = create(:merchant)
  end

  it 'can link from the merchant index page to the new merchant item page' do
    visit merchant_items_path(@merchant_1)

    click_link('Create a New Item')

    expect(current_path).to eq(new_merchant_item_path(@merchant_1))
  end

  it 'can create a new merchant item' do
    visit new_merchant_item_path(@merchant_1)

    expect(page).to have_content('Create a New Merchant Item')

    fill_in('Name', with: 'Diagon Alley')
    fill_in('Description', with: "The truth. It is a beautiful and terrible thing, and should therefore be treated with great caution.")
    fill_in('Unit Price', with: 48730)

    click_on('Submit')

    # Then I am taken back to the items index page ** This means the merch item page, right?
    expect(Item.last.name).to eq('Diagon Alley')
    expect(Item.last.description).to eq("The truth. It is a beautiful and terrible thing, and should therefore be treated with great caution.")
    expect(Item.last.unit_price).to eq(48730)
    expect(Item.last.enabled).to eq(false)

    expect(current_path).to eq(merchant_items_path(@merchant_1))
    expect(page).to have_content('Diagon Alley')
  end
end
