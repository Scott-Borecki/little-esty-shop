require 'rails_helper'

RSpec.describe 'Merchant Items Show Page' do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @item1 = create(:item, enabled: true, merchant: @merchant1, unit_price: 59_400)
    @item2 = create(:item, enabled: true, merchant: @merchant1, unit_price: 95_658)
  end

  describe "edit a merchant's item" do
    it "links to the merchant's item edit page" do
      visit merchant_item_path(@merchant1, @item1)

      click_link('Update Item Information')

      expect(current_path).to eq(edit_merchant_item_path(@merchant1, @item1))
    end

    it "updates a merchant's item" do
      visit edit_merchant_item_path(@merchant1, @item1)

      expect(page).to have_field('Name', with: @item1.name)
      expect(page).to have_field('Description', with: @item1.description)
      expect(page).to have_field('Unit Price', with: @item1.unit_price)

      fill_in('Name', with: 'Rubeus Hagrid')
      fill_in('Description', with: "Mad and hairy? You wouldn't be taking about me, now, would you?")
      fill_in('Unit Price', with: 94_753)

      click_button 'Submit'

      expect(current_path).to eq(merchant_item_path(@merchant1, @item1))
      expect(page).to have_content('Rubeus Hagrid')
      expect(page).to have_content("Mad and hairy? You wouldn't be taking about me, now, would you?")
      expect(page).to have_content('$947.53')
      expect(page).to have_content("#{@item1.reload.name}'s information was successfully updated!")
      expect(page).to have_no_content("#{@item1.reload.name}'s information was not successfully updated!")
    end
  end
end
