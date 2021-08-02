class InvoicesController < ApplicationController
  before_action :get_merchant, only: [:index, :show]

  def index
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  private

  def get_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
