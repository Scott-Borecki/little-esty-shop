require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  # before :each do
  #
  # end
  #
  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end

  describe 'instance methods' do
    describe '#enabled?' do
      let!(:merchant1) { create(:merchant) }
      let!(:merchant2) { create(:merchant, enabled: false) }
      context 'when merchant is enabled' do
        specify { expect(merchant1).to be_enabled }
      end

      context 'when merchant is disabled' do
        specify { expect(merchant2).to_not be_enabled }
      end
    end
  end
end
