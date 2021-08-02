class InvoiceItemsController < ApplicationController
  before_action :get_merchant, only: [:update]

  def update
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(status: params[:invoice_item][:status])
    invoice = Invoice.find(invoice_item.invoice_id)
    redirect_to("/merchants/#{@merchant.id}/invoices/#{invoice.id}")
  end

  private

  def get_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
