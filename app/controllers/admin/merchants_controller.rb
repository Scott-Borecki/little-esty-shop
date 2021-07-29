class Admin::MerchantsController < ApplicationController
  before_action :fetch_current_merchant, only: [:edit, :show, :update]

  def index
    @merchants = Merchant.all
  end

  def show
  end

  def edit
  end

  def update
    @merchant.update(merchant_params)
    redirect_to admin_merchant_path(@merchant)
    flash[:notice] = "Update successful!"
  end

  private

  def merchant_params
    params.permit(:name, :enabled)
  end

  def fetch_current_merchant
    @merchant = Merchant.find(params[:id])
  end
end
