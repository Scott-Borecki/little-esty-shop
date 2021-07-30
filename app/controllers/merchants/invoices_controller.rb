class Merchants::InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.uniq
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:invoice_id])
    @customer = Customer.joins(:invoices)
      .where('invoices.id = ?', params[:invoice_id]).first
    @invoice_items = @merchant.invoice_items
      .where('invoice_id = ?', @invoice.id)
    @total_revenue = @invoice_items.sum(:unit_price)
  end
end
