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

  # before :each do
  #
  # end
  #
  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
  #
  # describe 'instance methods' do
  #   describe '#' do
  #   end
  # end
end
