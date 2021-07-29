class Admin::MerchantsController < ApplicationController
  before_action :fetch_current_merchant, only: [:edit, :show, :update]
  before_action :fetch_merchant_collection, only: [:index]

  def index
  end

  def show
  end

  def new
  end

  def create
    # TODO (Scott Borecki): Add sad path if creation fails
    Merchant.create!(merchant_params)
    redirect_to admin_merchants_path
  end

  def edit
  end

  def update
    # TODO (Scott Borecki): Add sad path if update fails
    @merchant.update!(merchant_params)
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

  def fetch_merchant_collection
    @merchants = Merchant.all
  end
end
