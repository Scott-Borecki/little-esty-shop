require 'rails_helper'

RSpec.describe 'Merchant Items Show Page' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, enabled: true, merchant: @merchant_1, unit_price: 59400)
    @item_2 = create(:item, enabled: true, merchant: @merchant_1, unit_price: 95658)
  end

  describe "a merchant's item's show page" do
    it "can link to the merchant's item's show page" do
      visit merchant_items_path(@merchant_1)

      click_link("#{@item_1.name}")

      expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
    end

    it "show the item's name, description, and price" do
      visit merchant_item_path(@merchant_1, @item_1)

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content("$594.00")

      expect(page).to_not have_content(@item_2.name)
      expect(page).to_not have_content(@item_2.description)
      expect(page).to_not have_content("$956.58")
    end
  end
end
