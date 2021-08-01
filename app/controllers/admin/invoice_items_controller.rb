class Admin::InvoiceItemsController < ApplicationController
  def update
    InvoiceItem.find(invoice_item_params[:id])
               .update(invoice_item_params)
    redirect_to admin_invoice_path(params[:invoice_id])
  end

  private

  def invoice_item_params
    params[:invoice_item][:id] = params[:id]
    params.require(:invoice_item).permit(:id, :status)
  end
end
