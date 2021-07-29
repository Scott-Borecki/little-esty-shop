class InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = Invoice.select("DISTINCT invoices.*")
      .joins(invoice_items: :item)
      .where('items.merchant_id = ?', params[:merchant_id])
  end

  def show
    
  end

end
