class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    # All items for a specific Merchant
    @items = @merchant.items
  end
end
