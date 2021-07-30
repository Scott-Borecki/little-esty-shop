require 'rails_helper'

RSpec.describe '/admin/merchants/' do
  # CUSTOMER
  let!(:customer) { create(:customer) }

  # MERCHANTS
  let!(:merchant1) { create(:enabled_merchant) }
  let!(:merchant2) { create(:enabled_merchant) }
  let!(:merchant3) { create(:enabled_merchant) }
  let!(:merchant4) { create(:disabled_merchant) }
  let!(:merchant5) { create(:disabled_merchant) }
  let!(:merchant6) { create(:enabled_merchant) }

  # ITEMS
  let!(:item1) { create(:item, merchant: merchant1) }
  let!(:item2) { create(:item, merchant: merchant2) }
  let!(:item3) { create(:item, merchant: merchant3) }
  let!(:item4) { create(:item, merchant: merchant4) }
  let!(:item5) { create(:item, merchant: merchant5) }
  let!(:item6) { create(:item, merchant: merchant6) }

  # INVOICES
  let!(:invoice1) { create(:invoice, :completed, customer: customer) }
  let!(:invoice2) { create(:invoice, :completed, customer: customer) }
  let!(:invoice3) { create(:invoice, :completed, customer: customer) }
  let!(:invoice4) { create(:invoice, :completed, customer: customer) }
  let!(:invoice5) { create(:invoice, :completed, customer: customer) }
  let!(:invoice6) { create(:invoice, :completed, customer: customer) }

  # TRANSACTIONS
  let!(:transaction1) { create(:transaction, :failed, invoice: invoice1) }
  let!(:transaction2) { create(:transaction, :success, invoice: invoice2) }
  let!(:transaction3) { create(:transaction, :success, invoice: invoice3) }
  let!(:transaction4) { create(:transaction, :success, invoice: invoice4) }
  let!(:transaction5) { create(:transaction, :success, invoice: invoice5) }
  let!(:transaction6) { create(:transaction, :success, invoice: invoice6) }

  # INVOICE ITEMS
  let!(:invoice_item1a) { create(:invoice_item, :shipped, item: item1, invoice: invoice1, quantity: 2, unit_price: 10) }
  let!(:invoice_item1b) { create(:invoice_item, :shipped, item: item1, invoice: invoice1, quantity: 5, unit_price: 20) }
  let!(:invoice_item2a) { create(:invoice_item, :shipped, item: item2, invoice: invoice2, quantity: 4, unit_price: 10) }
  let!(:invoice_item2b) { create(:invoice_item, :shipped, item: item2, invoice: invoice2, quantity: 5, unit_price: 20) }
  let!(:invoice_item3a) { create(:invoice_item, :shipped, item: item3, invoice: invoice3, quantity: 1, unit_price: 10) }
  let!(:invoice_item3b) { create(:invoice_item, :shipped, item: item3, invoice: invoice3, quantity: 5, unit_price: 20) }
  let!(:invoice_item4a) { create(:invoice_item, :shipped, item: item4, invoice: invoice4, quantity: 3, unit_price: 10) }
  let!(:invoice_item4b) { create(:invoice_item, :shipped, item: item4, invoice: invoice4, quantity: 5, unit_price: 20) }
  let!(:invoice_item5a) { create(:invoice_item, :shipped, item: item5, invoice: invoice5, quantity: 5, unit_price: 10) }
  let!(:invoice_item5b) { create(:invoice_item, :shipped, item: item5, invoice: invoice5, quantity: 5, unit_price: 20) }
  let!(:invoice_item6a) { create(:invoice_item, :shipped, item: item6, invoice: invoice6, quantity: 6, unit_price: 10) }
  let!(:invoice_item6b) { create(:invoice_item, :shipped, item: item6, invoice: invoice6, quantity: 5, unit_price: 20) }

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
        enabled_merchants  = [merchant1, merchant2, merchant3, merchant6]
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
          expect(page).to have_content(merchant6.name)
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
          expect(page).to have_no_content(merchant6.name)
          expect(page).to have_content(merchant4.name)
          expect(page).to have_content(merchant5.name)
        end
      end

      it 'displays a link to create a new merchant' do
        expect(page).to have_link('Create New Merchant')
      end

      context 'within the top 5 merchants section' do
        it 'displays the names of the top 5 merchants by total revenue generated' do
          top_five_merchants = [merchant6, merchant5, merchant2, merchant4, merchant3]

          within('#top-five-merchants') do
            top_five_merchants.each do |merchant|
              expect(page).to have_content(merchant.name)
            end

            expect(merchant6.name).to appear_before(merchant5.name)
            expect(merchant5.name).to appear_before(merchant2.name)
            expect(merchant2.name).to appear_before(merchant4.name)
            expect(merchant4.name).to appear_before(merchant3.name)
            expect(page).to have_no_content(merchant1.name)
          end
        end

        it 'links the names of the top 5 merchants to their admin merchant show page' do
          top_five_merchants = [merchant6, merchant5, merchant2, merchant4, merchant3]

          within('#top-five-merchants') do
            top_five_merchants.each do |merchant|
              expect(page).to have_link(merchant.name)
            end

            expect(page).to have_no_link(merchant1.name)
          end
        end

        it 'displays the total revenue generated next to each top 5 merchants' do
          top_five_merchants = [merchant6, merchant5, merchant2, merchant4, merchant3]

          top_five_merchants.each do |merchant|
            within("#top-merchant-#{merchant.id}") do
              expect(page).to have_content(merchant.total_revenue)
            end
          end
        end
      end

      describe 'when I click on the name of a merchant' do
        context 'within the enabled/disabled section' do
          it 'takes me to the merchants admin show page (/admin/merchants/merchant_id)' do
            Merchant.all.each do |merchant|
              visit admin_merchants_path

              within("#merchant-#{merchant.id}") do
                click_link merchant.name
              end

              expect(current_path).to eq(admin_merchant_path(merchant))
            end
          end
        end

        context 'within the top 5 merchants section' do
          it 'takes me to the merchants admin show page (/admin/merchants/merchant_id)' do
            top_five_merchants = [merchant6, merchant5, merchant2, merchant4, merchant3]

            top_five_merchants.each do |merchant|
              visit admin_merchants_path

              within("#top-five-merchants") do
                click_link merchant.name
              end

              expect(current_path).to eq(admin_merchant_path(merchant))
            end
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
        before { click_link 'Create New Merchant' }

        it 'takes me to the new admin merchant page' do
          expect(current_path).to eq(new_admin_merchant_path)
        end
      end
    end
  end
end
