require 'rails_helper'

RSpec.describe 'Merchant Items Index Page' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, enabled: true, merchant: @merchant_1)
    @item_2 = create(:item, enabled: true, merchant: @merchant_1)
    @item_3 = create(:item, enabled: false, merchant: @merchant_1)
    @item_4 = create(:item, enabled: true, merchant: @merchant_2)
    @item_5 = create(:item, enabled: false, merchant: @merchant_2)

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

  it 'has a button next to each item name to disable OR enable that item' do
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
      expect(page).to have_button('Enable')
      expect(page).to_not have_button('Disable')
    end
  end

  it 'has two sections: one for enabled items and one for disabled items' do
    within "#all-enabled" do
      expect(page).to have_content("Enabled Items")
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)
    end

    within "#all-disabled" do
      expect(page).to have_content("Disabled Items")
      expect(page).to_not have_content(@item_1.name)
      expect(page).to_not have_content(@item_2.name)
      expect(page).to have_content(@item_3.name)
    end
  end

# Then I see the names of the top 5 most popular items ranked by total revenue generated
# And I see that each item name links to my merchant item show page for that item
# And I see the total revenue generated next to each item name
#
# Notes on Revenue Calculation:
# 
# Only invoices with at least one successful transaction should count towards revenue
# Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
# Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)

end
