class Api::V1::MerchantsController < ApplicationController
  responds_to :json

  def index
    responds_with Merchant.all
  end

  def show
    responds_with Merchant.find(params[:id])
  end

  def create
    responds_with Merchant.create(merchant_params)
  end

  def update
    responds_with Merchant.update(params[:id], merchant_params)
  end

  def destroy
    responds_with Merchant.destroy(params[:id])
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
