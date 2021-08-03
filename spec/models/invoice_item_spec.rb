require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
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
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe 'validations' do
    statuses = { pending: 0, packaged: 1, shipped: 2 }
    it { should define_enum_for(:status).with(statuses) }

    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  before :each do
    # merchants
    @merchant1 = Merchant.create!(name: 'Dandy')

    # items
    @item1 = @merchant1.items.create!(name: 'Pogo stick', description: 'Jumpin Stick', unit_price: 100, enabled: true)

    # customers
    @customer1 = Customer.create!(first_name: 'Super', last_name: 'Mario')

    # invoices
    @invoice1 = @customer1.invoices.create!(status: 0)

    # invoice_items
    @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 1111, status: 0)
  end

  describe 'instance methods' do
    describe '#find_item_name' do
      it 'can find the item name' do
        expect(@invoice_item1.find_item_name).to eq(@item1.name)
      end
    end

    describe '#find_invoice_id' do
      it 'can find the invoice id' do
        expect(@invoice_item1.find_invoice_id).to eq(@invoice1.id)
      end
    end
  end
end
