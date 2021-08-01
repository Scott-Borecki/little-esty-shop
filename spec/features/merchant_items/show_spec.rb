require 'rails_helper'

RSpec.describe 'Merchant Items Show Page' do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @item1 = create(:item, enabled: true, merchant: @merchant1, unit_price: 59_400)
    @item2 = create(:item, enabled: true, merchant: @merchant1, unit_price: 95_658)
  end

  describe "a merchant's item's show page" do
    it "links to the merchant's item's show page" do
      visit merchant_items_path(@merchant1)

      click_link("#{@item1.name}")

      expect(current_path).to eq(merchant_item_path(@merchant1, @item1))
    end

    it "shows the item's name, description, and price" do
      visit merchant_item_path(@merchant1, @item1)

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.description)
      expect(page).to have_content('$594.00')
      expect(page).to have_content("$#{@item1.unit_price / 100.00}")

      expect(page).to have_no_content(@item2.name)
      expect(page).to have_no_content(@item2.description)
      expect(page).to have_no_content("$#{@item2.unit_price / 100.00}")
    end
  end
end
