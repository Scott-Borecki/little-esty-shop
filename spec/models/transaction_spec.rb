require 'rails_helper'

RSpec.describe Transaction, type: :model do
  # See /spec/factories.rb for more info on factories created
  create_factories

  specify { expect(Customer.all.count).to be_positive }
  specify { expect(Merchant.all.count).to be_positive }
  specify { expect(Item.all.count).to be_positive }
  specify { expect(Invoice.all.count).to be_positive }
  specify { expect(Transaction.all.count).to be_positive }
  specify { expect(InvoiceItem.all.count).to be_positive }

  describe 'relationships' do
    it { should belong_to(:invoice) }
  end

  describe 'validations' do
    it { should define_enum_for(:result).with(failed: 0, success: 1) }

    it { should validate_presence_of(:credit_card_number) }
    it { should validate_numericality_of(:credit_card_number) }
    it { should validate_length_of(:credit_card_number).is_at_least(15).is_at_most(16) }
    it { should validate_presence_of(:result) }
  end

  describe 'class methods' do
    describe '.successful_transactions' do
      it 'returns all the successful transactions' do
        successful_transactions = [transaction2, transaction3, transaction4, transaction5, transaction6]
        expect(Transaction.successful_transactions).to eq(successful_transactions)
      end
    end
  end
end
