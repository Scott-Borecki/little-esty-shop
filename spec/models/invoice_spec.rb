require 'rails_helper'
require_relative '../create_test_objects.rb'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'validations' do
    statuses = { "in progress": 0, cancelled: 1, completed: 2 }
    it { should define_enum_for(:status).with(statuses) }

    it { should validate_presence_of(:status) }
  end

  describe 'class methods' do
    # See /spec/factories.rb for more info on factories created
    create_factories

    describe '.incomplete_invoices' do
      context 'when the items have been shipped' do
        it 'returns the invoice id' do
          shipped_items = [invoice1.id, invoice3.id, invoice5a.id, invoice5b.id]

          shipped_items.each do |shipped_item_id|
            expect(Invoice.incomplete_invoices.ids).to include(shipped_item_id)
          end
        end
      end

      context 'when the items have not been shipped' do
        it 'doest not return the invoice id' do
          not_shipped_items = [invoice2a, invoice2b, invoice2c, invoice2d,
                               invoice2e, invoice4a, invoice4b, invoice4c,
                               invoice4d, invoice6a, invoice6b, invoice6c]

          not_shipped_items.each do |not_shipped_item_id|
            expect(Invoice.incomplete_invoices).to_not include(not_shipped_item_id)
          end
        end
      end
    end
  end

  describe 'instance methods' do
    describe '#items_belonging_to' do
      xit 'returns the invoice item status as well as all item attributes for an invoice' do
        TestData.invoice_items
        expect(Invoice.first.items_belonging_to[0].name).to eq("Madam Rosmerta")
        expect(Invoice.first.items_belonging_to[0].unit_price).to eq(8363)
        expect(Invoice.first.items_belonging_to[0].quantity).to eq(11)
        expect(Invoice.first.items_belonging_to[0].status).to eq("packaged")

        expect(Invoice.first.items_belonging_to[1].name).to eq("Mary Cattermole")
        expect(Invoice.first.items_belonging_to[1].unit_price).to eq(1177)
        expect(Invoice.first.items_belonging_to[1].quantity).to eq(9)
        expect(Invoice.first.items_belonging_to[1].status).to eq("shipped")

        expect(Invoice.first.items_belonging_to[2].name).to eq("Sirius Black")
        expect(Invoice.first.items_belonging_to[2].unit_price).to eq(4960)
        expect(Invoice.first.items_belonging_to[2].quantity).to eq(15)
        expect(Invoice.first.items_belonging_to[2].status).to eq("pending")
      end
    end

    describe '#invoice_total_revenue' do
      it 'can calculate total revenue for an invoice' do
        @merchant1 = Merchant.create!(name: 'Dandy')
        @merchant2 = Merchant.create!(name: 'Randy')

        # items
        @item1 = @merchant1.items.create!(name: 'Pogo stick', description: 'Jumpin  Stick', unit_price: 100, enabled: true)
        @item2 = @merchant1.items.create!(name: 'Yo - Yo', description: 'Goes and yos',   unit_price: 100, enabled: true)
        @item3 = @merchant1.items.create!(name: 'Rollerskates', description: 'Lets roll',   unit_price: 100, enabled: true)
        @item4 = @merchant2.items.create!(name: 'Fun Dip', description: 'Dip the fun',  unit_price: 100, enabled: true)

        # customers
        @customer1 = Customer.create!(first_name: 'Super', last_name: 'Mario')
        @customer2 = Customer.create!(first_name: 'Donkey', last_name: 'Kong')

        # invoices
        @invoice1 = @customer1.invoices.create!(status: 0)
        @invoice2 = @customer2.invoices.create!(status: 0)

        # invoice_items
        @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id:  @invoice1.id, quantity: 10, unit_price: 100, status: 0)
        @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id:  @invoice1.id, quantity: 10, unit_price: 200, status: 1)
        @invoice_item3 = InvoiceItem.create!(item_id: @item4.id, invoice_id:  @invoice2.id, quantity: 10, unit_price: 100, status: 1)

        expect(@invoice1.invoice_total_revenue).to eq(3000)
      end
    end
  end
end
