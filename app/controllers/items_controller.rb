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
    item.update(item_params)

    if item.save
      redirect_to merchant_item_path
      flash[:notice] = "Item information has been successfully updated!"
    # else
    #   flash[:alert] = "Item was not updated"
    #   redirect_to edit_merchant_item_path
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end
