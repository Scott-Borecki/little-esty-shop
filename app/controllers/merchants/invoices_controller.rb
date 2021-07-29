class Merchants::InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = Invoice.select('DISTINCT invoices.*')
      .joins(invoice_items: :item)
      .where('items.merchant_id = ?', params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:invoice_id])
    @customer = Customer.joins(:invoices)
      .where('invoices.id = ?', params[:invoice_id]).first
  end
end
