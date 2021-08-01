class Merchants::InvoicesController < ApplicationController
  before_action :get_merchant

  def index
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def get_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
