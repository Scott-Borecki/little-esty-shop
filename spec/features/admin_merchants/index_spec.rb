require 'rails_helper'

RSpec.describe '/admin/merchants/' do
  let!(:merchant1) { create(:enabled_merchant) }
  let!(:merchant2) { create(:enabled_merchant) }
  let!(:merchant3) { create(:enabled_merchant) }
  let!(:merchant4) { create(:disabled_merchant) }
  let!(:merchant5) { create(:disabled_merchant) }

  describe 'as an admin' do
    describe 'when I visit the admin merchants index (/admin/merchants)' do
      before { visit admin_merchants_path }

      specify { expect(current_path).to eq(admin_merchants_path) }
      specify { expect(Merchant.all.count).to be_positive }

      it 'displays the name of each merchant in the system' do
        Merchant.all.each do |merchant|
          expect(page).to have_content(merchant.name)
        end
      end

      it 'displays a button next to each merchant name to disable or enable that merchant' do
        enabled_merchants  = [merchant1, merchant2, merchant3]
        disabled_merchants = [merchant4, merchant5]

        enabled_merchants.each do |merchant|
          within("#merchant-#{merchant.id}") do
            expect(page).to have_button('Disable')
            expect(page).to have_no_button('Enable')
          end
        end

        disabled_merchants.each do |merchant|
          within("#merchant-#{merchant.id}") do
            expect(page).to have_button('Enable')
            expect(page).to have_no_button('Disable')
          end
        end
      end

      it 'displays an Enabled Merchants section with all the enabled merchants' do
        within('#enabled-merchants') do
          expect(page).to have_content('Enabled Merchants')
          expect(page).to have_no_content('Disabled Merchants')
          expect(page).to have_content(merchant1.name)
          expect(page).to have_content(merchant2.name)
          expect(page).to have_content(merchant3.name)
          expect(page).to have_no_content(merchant4.name)
          expect(page).to have_no_content(merchant5.name)
        end
      end

      it 'displays an Disabled Merchants section with all the disabled merchants' do
        within('#disabled-merchants') do
          expect(page).to have_content('Disabled Merchants')
          expect(page).to have_no_content('Enabled Merchants')
          expect(page).to have_no_content(merchant1.name)
          expect(page).to have_no_content(merchant2.name)
          expect(page).to have_no_content(merchant3.name)
          expect(page).to have_content(merchant4.name)
          expect(page).to have_content(merchant5.name)
        end
      end

      it 'displays a link to create a new merchant' do
        expect(page).to have_link('Create New Merchant')
      end

      describe 'when I click on the name of a merchant' do
        it 'takes me to the merchants admin show page (/admin/merchants/merchant_id)' do
          Merchant.all.each do |merchant|
            visit admin_merchants_path
            click_link merchant.name

            expect(current_path).to eq(admin_merchant_path(merchant))
          end
        end
      end

      describe 'when I click on the enable button' do
        before do
          within("#merchant-#{merchant4.id}") { click_button 'Enable' }
        end

        it 'redirects me back to the admin merchants index' do
          expect(current_path).to eq(admin_merchants_path)
        end

        it 'changes the merchants status' do
          expect(merchant4.enabled?).to be false

          merchant4.reload

          expect(merchant4.enabled?).to be true
        end
      end

      describe 'when I click on the disable button' do
        before do
          within("#merchant-#{merchant1.id}") { click_button 'Disable' }
        end

        it 'redirects me back to the admin merchants index' do
          expect(current_path).to eq(admin_merchants_path)
        end

        it 'changes the merchants status' do
          expect(merchant1.enabled?).to be true

          merchant1.reload

          expect(merchant1.enabled?).to be false
        end
      end

      describe 'when I click on Create New Merchant' do
        before { click_link 'Create New Merchant'}

        it 'takes me to the new admin merchant page' do
          expect(current_path).to eq(new_admin_merchant_path)
        end
      end
    end
  end
end
