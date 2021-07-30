class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    # binding.pry
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to merchant_item_path
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end
