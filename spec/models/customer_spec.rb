require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    it { should have_many(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  # TODO: Add validation to check customer is a Customer instance (See Line 25 below).
  it 'can build a customer' do
    customer1 = create(:customer)
    
    expect(customer1.first_name).to be_a(String)
    expect(customer1.last_name).to be_a(String)
    # expect(customer1).to be_an_instance_of(Customer)
  end
end
