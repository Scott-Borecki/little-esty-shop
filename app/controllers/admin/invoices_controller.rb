class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
    binding.pry
  end
  
  def show
    @invoice = Invoice.find(invoice_params[:id])
  end

  private

  def invoice_params
    params.permit(:id)
  end
end
