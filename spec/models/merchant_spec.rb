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
        expect(merchant6.top_revenue_day).to eq("July 27, 2021")
      end
    end
  end
end
