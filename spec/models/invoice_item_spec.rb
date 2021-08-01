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

  describe 'class methods' do
    describe '.top_day' do
      it 'returns the top day by revenue generated' do
        # require "pry"; binding.pry
        expect(InvoiceItem.top_day).to eq()
      end
    end
  end
end
