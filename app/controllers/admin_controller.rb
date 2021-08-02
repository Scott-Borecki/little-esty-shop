class AdminController < ApplicationController
  def index
    @top_customers = Customer.top_five_by_successful_transactions
    @incomplete_invoices = Invoice.incomplete_invoices
  end
end
