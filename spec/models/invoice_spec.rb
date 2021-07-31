require 'rails_helper'

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

  it 'can build an invoice with a customer association' do
    customer_with_in_progress_invoices(invoice_count: 2)
    expect(Invoice.first.status).to eq("in progress")
    expect(Invoice.all.length).to eq(4)
  end

  before :each do
    # merchants
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
  end

  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end

  describe 'instance methods' do
    describe '#invoice_total_revenue' do
      it 'can calculate total revenue for an invoice' do
        expect(@invoice1.invoice_total_revenue).to eq(3000)
      end
    end
  end
end
