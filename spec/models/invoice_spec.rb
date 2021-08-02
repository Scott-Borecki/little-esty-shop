require 'rails_helper'
require_relative '../spec_data.rb'

RSpec.describe Invoice, type: :model do
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

  # DELETE? (Scott Borecki): I think we can remove this test?
  it 'builds an invoice with a customer association' do
    expect(Invoice.all.size).to eq(16)
    customer_with_in_progress_invoices(invoice_count: 2)
    expect(Invoice.last.status).to eq('in progress')
    expect(Invoice.all.size).to eq(18)
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
        expect(invoice1.invoice_total_revenue).to eq(120)
        expect(invoice2a.invoice_total_revenue).to eq(60)
        expect(invoice3.invoice_total_revenue).to eq(110)
      end
    end
  end
end
