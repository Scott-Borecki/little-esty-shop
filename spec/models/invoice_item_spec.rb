require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
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

  describe 'class methods' do
    before :each do
      @merchant1 = Merchant.create!(name: 'Dandy')

      @item1 = @merchant1.items.create!(name: 'Idaho Potato', description: 'Brown', unit_price: 100, enabled: true)
      @item2 = @merchant1.items.create!(name: 'Fingerling', description: 'Like finger potatoes', unit_price: 100, enabled: true)
      @item3 = @merchant1.items.create!(name: 'Purple Potato', description: 'Stylin', unit_price: 100, enabled: true)
      @item4 = @merchant1.items.create!(name: 'Sweet Potato', description: 'YOM YOM', unit_price: 100, enabled: true)
      @item5 = @merchant1.items.create!(name: 'Yukon Gold', description: 'GOLDDDDDD', unit_price: 100, enabled: true)

      @customer1 = Customer.create!(first_name: 'Super', last_name: 'Mario')

      @invoice1 = @customer1.invoices.create!(status: 0)
      @invoice2 = @customer1.invoices.create!(status: 0)
      @invoice3 = @customer1.invoices.create!(status: 0)
      @invoice4 = @customer1.invoices.create!(status: 0)

      @invoice_item1 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice4.id, quantity: 10, unit_price: 1111, status: 0, created_at: "2021-01-04 00:21:46")
      @invoice_item2 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 10, unit_price: 1111, status: 0, created_at: "2021-03-04 00:21:46")
      @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice2.id, quantity: 10, unit_price: 1111, status: 0, created_at: "2021-05-04 00:21:46")
      @invoice_item4 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 1111, status: 0, created_at: "2021-08-04 00:21:46")
    end

    describe '.oldest_to_newest' do
      it 'orders invoice items from oldest to newest by created at' do
        expect(InvoiceItem.oldest_to_newest).to eq([@invoice_item4, @invoice_item3, @invoice_item2, @invoice_item1])
      end
    end
  end

  describe 'instance methods' do
    before :each do
      @merchant1 = Merchant.create!(name: 'Dandy')

      @item1 = @merchant1.items.create!(name: 'Idaho Potato', description: 'Brown', unit_price: 100, enabled: true)
      @item2 = @merchant1.items.create!(name: 'Fingerling', description: 'Like finger potatoes', unit_price: 100, enabled: true)
      @item3 = @merchant1.items.create!(name: 'Purple Potato', description: 'Stylin', unit_price: 100, enabled: true)
      @item4 = @merchant1.items.create!(name: 'Sweet Potato', description: 'YOM YOM', unit_price: 100, enabled: true)
      @item5 = @merchant1.items.create!(name: 'Yukon Gold', description: 'GOLDDDDDD', unit_price: 100, enabled: true)

      @customer1 = Customer.create!(first_name: 'Super', last_name: 'Mario')

      @invoice1 = @customer1.invoices.create!(status: 0)
      @invoice2 = @customer1.invoices.create!(status: 0)
      @invoice3 = @customer1.invoices.create!(status: 0)
      @invoice4 = @customer1.invoices.create!(status: 0)

      @invoice_item1 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice4.id, quantity: 10, unit_price: 1111, status: 0, created_at: "2021-01-04 00:21:46")
      @invoice_item2 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 10, unit_price: 1111, status: 0, created_at: "2021-03-04 00:21:46")
      @invoice_item3 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice2.id, quantity: 10, unit_price: 1111, status: 0, created_at: "2021-05-04 00:21:46")
      @invoice_item4 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 1111, status: 0, created_at: "2021-08-04 00:21:46")
    end

    describe '#find_item_name' do
      it 'can find the item name' do
        expect(@invoice_item1.find_item_name).to eq(@item4.name)
      end
    end

    describe '#find_invoice_id' do
      it 'can find the invoice id' do
        expect(@invoice_item1.find_invoice_id).to eq(@invoice4.id)
      end
    end
  end
end
