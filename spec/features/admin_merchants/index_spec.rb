require 'rails_helper'

RSpec.describe '/admin/merchants/' do
  describe 'as an admin' do
    describe 'when I visit the admin merchants index (/admin/merchants)' do
      let!(:merchant1) { create(:merchant) }
      let!(:merchant2) { create(:merchant) }
      let!(:merchant3) { create(:merchant) }
      let!(:merchants) { [merchant1, merchant2, merchant3] }

      before { visit '/admin/merchants' }

      specify { expect(current_path).to eq('/admin/merchants') }

      it 'displays the name of each merchant in the system' do
        merchants.each do |merchant|
          expect(page).to have_content(merchant.name)
        end
      end

      describe 'when I click on the name of a merchant' do
        it 'takes me to the merchants admin show page (/admin/merchants/merchant_id)' do
          click_link merchant1.name

          expect(current_path).to eq("/admin/merchants/#{merchant1.id}")
        end
      end
    end
  end
end
