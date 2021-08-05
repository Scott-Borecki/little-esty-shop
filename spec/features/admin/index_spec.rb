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
        # As an admin,
        # When I visit the admin dashboard
        # In the section for "Incomplete Invoices",
        # Next to each invoice id I see the date that the invoice was created
        # And I see the date formatted like "Monday, July 18, 2019"
        # And I see that the list is ordered from oldest to newest
        # it 'has the date that each incomplete invoice was created, sorted oldest first' do
        #   Merchant.destroy_all
        #   Customer.destroy_all
        #
        #   TestData.create_all_data
        # end
      end
    end
  end
end
