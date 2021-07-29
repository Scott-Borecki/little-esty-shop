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
      # "/merchants/#{@merchant_1.id}/items"
      visit merchant_items_path(@merchant_1)

      click_link("#{@item_1.name}")

      expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
    end

    it "show the item's name, description, and price" do
      # "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"
      visit merchant_item_path(@merchant_1, @item_1)

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content("$594.00")

      expect(page).to_not have_content(@item_2.name)
      expect(page).to_not have_content(@item_2.description)
      expect(page).to_not have_content("$956.58")
    end
  end

  describe "edit a merchant's item" do
    it "can link to the merchant's item edit page" do
      visit merchant_item_path(@merchant_1, @item_1)

      click_link("Update Item Information")

      expect(current_path).to eq(edit_merchant_item_path(@merchant_1, @item_1))
    end
  end

# it "can update a merchant's item" do

# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.

end
