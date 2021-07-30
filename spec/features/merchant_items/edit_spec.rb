require 'rails_helper'

RSpec.describe 'Merchant Items Show Page' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, enabled: true, merchant: @merchant_1, unit_price: 59400)
    @item_2 = create(:item, enabled: true, merchant: @merchant_1, unit_price: 95658)
  end

  describe "edit a merchant's item" do
    it "can link to the merchant's item edit page" do
      visit merchant_item_path(@merchant_1, @item_1)

      click_link('Update Item Information')

      expect(current_path).to eq(edit_merchant_item_path(@merchant_1, @item_1))
    end

    it "can update a merchant's item" do
      # /merchants/:merchant_id/items/:id/edit(.:format)
      visit edit_merchant_item_path(@merchant_1, @item_1)
      save_and_open_page

      expect(page).to have_field('Name', with: "#{@item_1.name}")
      expect(page).to have_field('Description', with: "#{@item_1.description}")
      expect(page).to have_field('Unit Price', with: "#{@item_1.unit_price}")

      fill_in('Name', with: 'Rubeus Hagrid')
      fill_in('Description', with: "Mad and hairy? You wouldn't be taking about me, now, would you?")
      fill_in('Unit Price', with: 94753)

      click_button 'Submit'

      expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))

      expect(page).to have_content('Rubeus Hagrid')
      expect(page).to have_content("Mad and hairy? You wouldn't be taking about me, now, would you?")
      expect(page).to have_content("$947.53")

      # And I see a flash message stating that the information has been successfully updated.
    end
  end
end
