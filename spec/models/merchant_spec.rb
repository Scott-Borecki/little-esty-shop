require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  #
  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
  #
  describe 'instance methods' do
    before :each do
      # merchants
      @merchant1 = Merchant.create!(name: 'Joe Schmo')
      @merchant2 = Merchant.create!(name: 'Gertie')

      # items
      @item1 = @merchant1.items.create!(name: 'Pogo stick', description: 'Jumpin Stick', unit_price: 100, enabled: true)
      @item2 = @merchant1.items.create!(name: 'Yo - Yo', description: 'Goes and yos', unit_price: 100, enabled: true)
      @item3 = @merchant1.items.create!(name: 'Rollerskates', description: 'Lets roll', unit_price: 100, enabled: true)
      @item4 = @merchant2.items.create!(name: 'Fun Dip', description: 'Dip the fun', unit_price: 100, enabled: true)

      # customers
      @customer1 = Customer.create!(first_name: 'Sinead', last_name: 'Maguire')
      @customer2 = Customer.create!(first_name: 'Amy', last_name: 'Russel')

      # invoices
      @invoice1 = @customer1.invoices.create!(status: 0)
      @invoice2 = @customer1.invoices.create!(status: 0)
      @invoice3 = @customer2.invoices.create!(status: 0)

      # invoice_items
      @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 1000, status: 0)
      @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 2000, status: 1)
      @invoice_item3 = InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice2.id, quantity: 10, unit_price: 100, status: 1)
      @invoice_item4 = InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 20, unit_price: 100, status: 1)
    end

    describe '#unique_invoices' do
      it 'can find unique invoices for a merchant' do
        expect(@merchant1.unique_invoices).to eq([@invoice1, @invoice3])
      end
    end

    describe '#invoice_items_for_merchant' do
      it 'can find merchant1 invoice items for invoice1' do
        expect(@merchant1.invoice_items_for_invoice(@invoice1.id)).to eq([@invoice_item1, @invoice_item2])
      end
    end
  end
end
