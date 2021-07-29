require 'rails_helper'

RSpec.describe '/admin/merchants/merchant_id' do
  describe 'as an admin' do
    describe 'when I visit the admin merchants show page (/admin/merchants/merchant_id)' do
      let!(:merchant1) { create(:merchant, enabled: true) }
      let!(:merchant2) { create(:merchant, enabled: true) }
      let!(:merchant3) { create(:merchant, enabled: true) }
      let!(:merchants) { [merchant1, merchant2, merchant3] }

      before { visit admin_merchant_path(merchant1) }

      specify { expect(current_path).to eq(admin_merchant_path(merchant1)) }

      it 'displays the name of the merchant' do
        expect(page).to have_content(merchant1.name)
        expect(page).to have_no_content(merchant2.name)
        expect(page).to have_no_content(merchant3.name)
      end

      it 'has a link to update the merchants information' do
        expect(page).to have_link('Update Merchant')
      end

      describe 'when I click the update link' do
        it 'takes me to a page to edit the merchant' do
          click_link('Update Merchant')

          expect(current_path).to eq(edit_admin_merchant_path(merchant1))
        end
      end
    end
  end
end
