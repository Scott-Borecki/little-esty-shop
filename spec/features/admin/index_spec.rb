require 'rails_helper'
require_relative '../../create_test_objects.rb'

RSpec.describe 'admin dashboard (/admin)' do
  # See /spec/factories.rb for more info on factories created
  create_factories

  describe 'object creation for tests' do
    specify { expect(Customer.all.count).to be_positive }
    specify { expect(Merchant.all.count).to be_positive }
    specify { expect(Item.all.count).to be_positive }
    specify { expect(Invoice.all.count).to be_positive }
    specify { expect(Transaction.all.count).to be_positive }
    specify { expect(InvoiceItem.all.count).to be_positive }
  end

  describe 'as an admin' do
    describe 'when I visit the admin dashboard (/admin)' do
      before { visit admin_index_path }

      specify { expect(current_path).to eq(admin_index_path) }

      it 'displays a header indicating that I am on the admin dashboard' do
        visit '/admin'
        expect(page).to have_content('Admin Dashboard')
      end

      it 'displays a link to the admin merchants index (/admin/merchants)' do
        expect(page).to have_link('Admin Merchants Index')

        click_link 'Admin Merchants Index'

        expect(current_path).to eq(admin_merchants_path)
      end

      it 'displays a link to the admin merchants index (/admin/invoices)' do
        expect(page).to have_link('Admin Invoices Index')

        click_link 'Admin Invoices Index'

        expect(current_path).to eq(admin_invoices_path)
      end

      describe 'when I look in the top 5 customers section' do
        it 'displays the names and number of puchases of the top 5 customers' do
          top_customers = Customer.top_five_by_successful_transactions

          within '#top-five-customers' do
            expect(page).to have_content('Top Customers')
            top_customers.each do |customer|
              expect(page).to have_content("#{customer.first_name} #{customer.last_name} - #{customer.count} purchases")
            end
          end
        end
      end

      describe 'when I look in the incomplete invoices section' do
        it 'displays a list of the ids of all invoices that have items that have not yet been shipped' do
          not_shipped_items = [invoice1.id, invoice3.id, invoice5a.id, invoice5b.id]
          shipped_items = [invoice2a, invoice2b, invoice2c, invoice2d,
                           invoice2e, invoice4a, invoice4b, invoice4c,
                           invoice4d, invoice6a, invoice6b, invoice6c]

          within '#incomplete-invoices' do
            not_shipped_items.each do |not_shipped_item_id|
              expect(page).to have_content("Invoice ##{not_shipped_item_id}")
            end

            shipped_items.each do |shipped_item_id|
              expect(page).to have_no_content(shipped_item_id)
            end
          end
        end

        it 'links the invoice ids to that invoices admin show page' do
          not_shipped_items = [invoice1.id, invoice3.id, invoice5a.id, invoice5b.id]
          shipped_items = [invoice2a, invoice2b, invoice2c, invoice2d,
                           invoice2e, invoice4a, invoice4b, invoice4c,
                           invoice4d, invoice6a, invoice6b, invoice6c]

          within '#incomplete-invoices' do
            not_shipped_items.each do |not_shipped_item_id|
              expect(page).to have_link(not_shipped_item_id.to_s)
            end

            shipped_items.each do |shipped_item_id|
              expect(page).to have_no_link(shipped_item_id.to_s)
            end
          end
        end

        it 'has the date that each incomplete invoice was created, sorted oldest first' do
          Merchant.destroy_all
          Customer.destroy_all
          customer = Customer.create(first_name: 'Ali', last_name:'baba')
          invoice1 = customer.invoices.create(status: 0, created_at: "2012-03-27 14:53:59")
          invoice2 = customer.invoices.create(status: 0, created_at: "2014-03-27 14:53:59")
          invoice3 = customer.invoices.create(status: 0, created_at: "2010-03-27 14:53:59")
          invoice4 = customer.invoices.create(status: 0, created_at: "2011-03-27 14:53:59")
          invoice5 = customer.invoices.create(status: 0, created_at: "2011-03-27 14:53:59")
          TestData.create_merchants
          TestData.create_items
          inv_item1 = invoice1.invoice_items.create(item_id: Item.first.id, quantity: 1, status: 0, unit_price:1)
          inv_item2 = invoice2.invoice_items.create(item_id: Item.first.id, quantity: 1, status: 1, unit_price:1)
          inv_item3 = invoice5.invoice_items.create(item_id: Item.first.id, quantity: 1, status: 2, unit_price:1)
          inv_item4 = invoice4.invoice_items.create(item_id: Item.first.id, quantity: 1, status: 0, unit_price:1)
          inv_item5 = invoice3.invoice_items.create(item_id: Item.first.id, quantity: 1, status: 0, unit_price:1)
          visit '/admin'
          expect("#{invoice3.id}").to appear_before("#{invoice4.id}")
          expect("#{invoice4.id}").to appear_before("#{invoice1.id}")
          expect("#{invoice1.id}").to appear_before("#{invoice2.id}")
          expect(page).to_not have_content("#{invoice5.id}")
        end
      end
    end
  end
end
