class Merchants::InvoicesController < ApplicationController
  before_action :get_merchant

  def index
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    item = InvoiceItem.find(params[:item_id])
    item.update(status: params[:status])
    redirect_to("/merchants/#{@merchant.id}/invoices/#{@invoice.id}")
  end

  def get_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
