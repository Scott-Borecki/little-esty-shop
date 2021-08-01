require 'rails_helper'

RSpec.describe Merchant, type: :model do
  # See /spec/factories.rb for more info on factories created
  create_factories

  describe 'object creation for tests' do
    specify { expect(Customer.all.count).to be_positive }
    specify { expect(Merchant.all.count).to be_positive }
    specify { expect(Item.all.count).to be_positive }
    specify { expect(Invoice.all.count).to be_positive }
    specify { expect(Transaction.all.count).to be_positive }
    specify { expect(InvoiceItem.all.count).to be_positive }

    it 'can build a merchant' do
      merchant1 = create(:merchant)

      expect(merchant1).to be_a(Merchant)
      expect(merchant1.name).to be_a(String)
      # TODO: Add test for default enabled status.
    end
  end

  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    describe '.disabled_merchants' do
      it 'returns all the disabled merchants' do
        enabled_merchants = [merchant1, merchant2, merchant3, merchant6]
        disabled_merchants = [merchant4, merchant5]

        expect(Merchant.disabled_merchants).to eq(disabled_merchants)
        expect(Merchant.disabled_merchants).to_not include(enabled_merchants)
      end
    end

    describe '.enabled_merchants' do
      it 'returns all the enabled merchants' do
        enabled_merchants = [merchant1, merchant2, merchant3, merchant6]
        disabled_merchants = [merchant4, merchant5]

        expect(Merchant.enabled_merchants).to eq(enabled_merchants)
        expect(Merchant.enabled_merchants).to_not include(disabled_merchants)
      end
    end

    describe '.top_five_merchants_by_revenue' do
      it 'returns the top five merchants by total revenue generated' do
        top_five_merchants = [merchant6, merchant5, merchant2, merchant4, merchant3]
        expect(Merchant.top_five_merchants_by_revenue).to eq(top_five_merchants)
      end

      it 'returns the revenue of each top merchant' do
        expect(Merchant.top_five_merchants_by_revenue[0].revenue).to eq(680)
        expect(Merchant.top_five_merchants_by_revenue[1].revenue).to eq(150)
        expect(Merchant.top_five_merchants_by_revenue[2].revenue).to eq(140)
        expect(Merchant.top_five_merchants_by_revenue[3].revenue).to eq(130)
        expect(Merchant.top_five_merchants_by_revenue[4].revenue).to eq(110)
      end
    end
  end

  describe 'instance methods' do
    describe '#enabled?' do
      context 'when merchant is enabled' do
        specify { expect(merchant1).to be_enabled }
      end

      context 'when merchant is disabled' do
        specify { expect(merchant4).to_not be_enabled }
      end
    end

    describe '#top_revenue_day' do
      it 'returns the top revenue day for the merchant' do
        expect(merchant6.top_revenue_day).to eq("Tuesday, July 27, 2021")
      end
    end

    describe '#top_day' do
      it 'returns the merchants top day'
    end
  end

  # TODO: Update tests to use all the same factories instead of the instance variables.  Combine with 'instance methods' describe block above.
  describe 'instance methods PART 2' do
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
