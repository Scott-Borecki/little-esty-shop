require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'object creation for tests' do
    # See /spec/factories.rb for more info on factories created
    create_factories

    specify { expect(Customer.all.count).to be_positive }
    specify { expect(Merchant.all.count).to be_positive }
    specify { expect(Item.all.count).to be_positive }
    specify { expect(Invoice.all.count).to be_positive }
    specify { expect(Transaction.all.count).to be_positive }
    specify { expect(InvoiceItem.all.count).to be_positive }

    it 'creates a new merchant' do
      new_merchant = create(:merchant)

      expect(new_merchant).to be_a(Merchant)
      expect(new_merchant.name).to be_a(String)
      expect(new_merchant.enabled).to be false
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
    # See /spec/factories.rb for more info on factories created
    create_factories
    
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
    # See /spec/factories.rb for more info on factories created
    create_factories

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

    describe '#unique_invoices' do
      it 'finds unique invoices for a merchant' do
        expect(merchant1.unique_invoices).to eq([invoice1])
        expect(merchant2.unique_invoices).to eq([invoice2a, invoice2b,
                                                 invoice2c, invoice2d,
                                                 invoice2e])
      end
    end

    describe '#invoice_items_for_merchant' do
      it 'finds merchant1 invoice items for invoice1' do
        expect(merchant1.invoice_items_for_invoice(invoice1.id))
          .to eq([invoice_item1a, invoice_item1b])
        expect(merchant2.invoice_items_for_invoice(invoice2a.id))
          .to eq([invoice_item2a, invoice_item2b])
      end
    end
  end
end
