require 'rails_helper'
require_relative '../spec_data.rb'
RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    statuses = { "in progress": 0, cancelled: 1, completed: 2 }
    it { should define_enum_for(:status).with(statuses) }

    it { should validate_presence_of(:status) }
  end

  it 'can build an invoice with a customer association' do
    customer_with_in_progress_invoices(invoice_count: 2)
    expect(Invoice.first.status).to eq("in progress")
    expect(Invoice.all.length).to eq(2)
  end

  #
  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
  #
  describe 'instance methods' do
    before :each do
      TestData.invoice_items
    end
    describe '#items_belonging_to' do
      it 'returns the invoice item status as well as all item attributes for an invoice' do
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
  end
end
