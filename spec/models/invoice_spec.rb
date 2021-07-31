require 'rails_helper'

RSpec.describe Invoice, type: :model do
  # See /spec/factories.rb for more info on factories created
  create_factories

  specify { expect(Customer.all.count).to be_positive }
  specify { expect(Merchant.all.count).to be_positive }
  specify { expect(Item.all.count).to be_positive }
  specify { expect(Invoice.all.count).to be_positive }
  specify { expect(Transaction.all.count).to be_positive }
  specify { expect(InvoiceItem.all.count).to be_positive }

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
    expect(Invoice.all.size).to eq(6)
    customer_with_in_progress_invoices(invoice_count: 2)

    expect(Invoice.last.status).to eq("in progress")
    expect(Invoice.all.size).to eq(8)
  end

  # before :each do
  #
  # end
  #
  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
  #
  # describe 'instance methods' do
  #   describe '#' do
  #   end
  # end
end
