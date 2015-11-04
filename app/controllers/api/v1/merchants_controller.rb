class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find(params[:id])
  end

  def find
    respond_with Merchant.find_by(merchant_params)
  end

  def find_all
    respond_with Merchant.where(merchant_params)
  end

  def random
    respond_with Merchant.order("RANDOM()").first
  end

  def items
    respond_with Merchant.find_by(merchant_params).items
  end

  def invoices
    respond_with Merchant.find_by(merchant_params).invoices
  end

  def revenue
    respond_with Merchant.revenue(merchant_params)
  end

  def favorite_customer
    respond_with Merchant.favorite_customer(params[:id])
  end

  private

  def merchant_params
    params.permit(:id,
                  :name,
                  :created_at,
                  :updated_at,
                  :date)
  end
end
