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
    item = Item.find(params[:id])
    item.update!(item_params)

    if item.save
      if item_params["enabled"] != nil
        redirect_to merchant_items_path
      else
        redirect_to merchant_item_path
      end
      flash[:notice] = "Item information has been successfully updated!"
    else
      flash[:alert] = "Item information was not successfully updated!"
      # redirect_to edit_merchant_item_path
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :enabled)
  end
end
