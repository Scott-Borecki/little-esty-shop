require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
  end

  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, enabled: true, merchant: @merchant_1)
    @item_2 = create(:item, enabled: true, merchant: @merchant_1)
    @item_3 = create(:item, enabled: false, merchant: @merchant_1)
  end

  describe 'class methods' do
    describe '.all_enabled' do
      it 'can return ONLY items where enabled is true' do
        expect(Item.all_enabled).to eq([@item_1, @item_2])
      end
    end

    describe '.all_disabled' do
      it 'can return ONLY items where enabled is false' do
        expect(Item.all_disabled).to eq([@item_3])
      end
    end
  end
  #
  # describe 'instance methods' do
  #   describe '#' do
  #   end
  # end
end
