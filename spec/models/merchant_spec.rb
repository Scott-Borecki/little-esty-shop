require 'rails_helper'

RSpec.describe Merchant, type: :model do
  let!(:merchant1) { create(:enabled_merchant) }
  let!(:merchant2) { create(:enabled_merchant) }
  let!(:merchant3) { create(:enabled_merchant) }
  let!(:merchant4) { create(:disabled_merchant) }
  let!(:merchant5) { create(:disabled_merchant) }
  let!(:merchant6) { create(:disabled_merchant) }

  specify { expect(Merchant.all.count).to be_positive }

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
    describe '.enabled_merchants' do
      it 'returns all the enabled merchants' do
        enabled_merchants = [merchant1, merchant2, merchant3]
        disabled_merchants = [merchant4, merchant5, merchant6]

        expect(Merchant.enabled_merchants).to eq(enabled_merchants)
        expect(Merchant.enabled_merchants).to_not include(disabled_merchants)
      end
    end

    describe '.disabled_merchants' do
      it 'returns all the disabled merchants' do
        enabled_merchants = [merchant1, merchant2, merchant3]
        disabled_merchants = [merchant4, merchant5, merchant6]

        expect(Merchant.disabled_merchants).to eq(disabled_merchants)
        expect(Merchant.disabled_merchants).to_not include(enabled_merchants)
      end
    end

    describe '.top_five_merchants_by_revenue' do
      it 'returns the top five merchants by total revenue generated' do
        customer = create(:customer)

        # MERCHANT01 - with failed transaction
        merchant01 = create(:enabled_merchant)
        item01 = create(:item, merchant: merchant01)
        invoice01 = create(:invoice, :completed, customer: customer)
        create(:transaction, :failed, invoice: invoice01)
        create(:invoice_item, :shipped, item: item01, invoice: invoice01, quantity: 2, unit_price: 10)
        create(:invoice_item, :shipped, item: item01, invoice: invoice01, quantity: 5, unit_price: 20)

        # MERCHANT02
        merchant02 = create(:enabled_merchant)
        item02 = create(:item, merchant: merchant02)
        invoice02 = create(:invoice, :completed, customer: customer)
        create(:transaction, :success, invoice: invoice02)
        create(:invoice_item, :shipped, item: item02, invoice: invoice02, quantity: 4, unit_price: 10)
        create(:invoice_item, :shipped, item: item02, invoice: invoice02, quantity: 5, unit_price: 20)

        # MERCHANT03
        merchant03 = create(:enabled_merchant)
        item03 = create(:item, merchant: merchant03)
        invoice03 = create(:invoice, :completed, customer: customer)
        create(:transaction, :success, invoice: invoice03)
        create(:invoice_item, :shipped, item: item03, invoice: invoice03, quantity: 1, unit_price: 10)
        create(:invoice_item, :shipped, item: item03, invoice: invoice03, quantity: 5, unit_price: 20)

        # MERCHANT04
        merchant04 = create(:enabled_merchant)
        item04 = create(:item, merchant: merchant04)
        invoice04 = create(:invoice, :completed, customer: customer)
        create(:transaction, :success, invoice: invoice04)
        create(:invoice_item, :shipped, item: item04, invoice: invoice04, quantity: 3, unit_price: 10)
        create(:invoice_item, :shipped, item: item04, invoice: invoice04, quantity: 5, unit_price: 20)

        # MERCHANT05
        merchant05 = create(:enabled_merchant)
        item05 = create(:item, merchant: merchant05)
        invoice05 = create(:invoice, :completed, customer: customer)
        create(:transaction, :success, invoice: invoice05)
        create(:invoice_item, :shipped, item: item05, invoice: invoice05, quantity: 5, unit_price: 10)
        create(:invoice_item, :shipped, item: item05, invoice: invoice05, quantity: 5, unit_price: 20)

        # MERCHANT06
        merchant06 = create(:enabled_merchant)
        item06 = create(:item, merchant: merchant06)
        invoice06 = create(:invoice, :completed, customer: customer)
        create(:transaction, :success, invoice: invoice06)
        create(:invoice_item, :shipped, item: item06, invoice: invoice06, quantity: 6, unit_price: 10)
        create(:invoice_item, :shipped, item: item06, invoice: invoice06, quantity: 5, unit_price: 20)

        top_five_merchants = [merchant06, merchant05, merchant02, merchant04, merchant03]
        expect(Merchant.top_five_merchants_by_revenue).to eq(top_five_merchants)
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
  end
end
