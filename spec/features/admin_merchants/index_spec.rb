require 'rails_helper'

RSpec.describe '/admin/merchants/' do
  describe 'as an admin' do
    describe 'when I visit the admin merchants index (/admin/merchants)' do
      let!(:merchant1) { create(:merchant) }
      let!(:merchant2) { create(:merchant) }
      let!(:merchant3) { create(:merchant) }
      let!(:merchant4) { create(:merchant, enabled: false) }
      let!(:merchant5) { create(:merchant, enabled: false) }
      let!(:merchants) { [merchant1, merchant2, merchant3, merchant4, merchant5] }

      before { visit admin_merchants_path }

      specify { expect(current_path).to eq(admin_merchants_path) }

      it 'displays the name of each merchant in the system' do
        merchants.each do |merchant|
          expect(page).to have_content(merchant.name)
        end
      end

      it 'displays a button next to each merchant name to disable or enable that merchant' do
        enabled_merchants  = [merchant1, merchant2, merchant3]
        disabled_merchants = [merchant4, merchant5]

        enabled_merchants.each do |merchant|
          within("#merchant-#{merchant.id}") do
            expect(page).to have_button('Disable')
          end
        end

        disabled_merchants.each do |merchant|
          within("#merchant-#{merchant.id}") do
            expect(page).to have_button('Enable')
          end
        end
      end

      describe 'when I click on the name of a merchant' do
        it 'takes me to the merchants admin show page (/admin/merchants/merchant_id)' do
          click_link merchant1.name

          expect(current_path).to eq(admin_merchant_path(merchant1))
        end
      end

      describe 'when I click on the enable button' do
        before do
          within("#merchant-#{merchant4.id}") do
            click_button 'Enable'
          end
          merchant4.reload
        end

        it 'redirects me back to the admin merchants index' do
          expect(current_path).to eq(admin_merchant_path(merchant4))
        end

        it 'changes the merchants status' do
          expect(merchant4.enabled?).to eq(true)
        end
      end

      describe 'when I click on the disable button' do
        before do
          within("#merchant-#{merchant1.id}") do
            click_button 'Disable'
          end
          merchant1.reload
        end
        it 'redirects me back to the admin merchants index' do
          expect(current_path).to eq(admin_merchant_path(merchant1))
        end

        it 'changes the merchants status' do
          expect(merchant1.enabled?).to eq(false)
        end
      end
    end
  end
end
