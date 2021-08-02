class AdminController < ApplicationController
  def index
    @top_customers = Customer.top_five_by_successful_transactions
    @invoices = Invoice.all
  end
end
