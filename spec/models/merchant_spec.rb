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
