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
    merchant = Merchant.find(params[:id]).revenue(merchant_params)
    respond_with serialized_message(merchant)
  end

  def favorite_customer
    respond_with Merchant.find(params[:id]).favorite_customer
  end

  def customers_with_pending_invoices
    respond_with Merchant.find(params[:id]).pending_customers
  end

  private

  def merchant_params
    params.permit(:id,
                  :name,
                  :created_at,
                  :updated_at,
                  :date)
  end

  def serialized_message(merchant)
    MerchantSerializer.new(merchant).revenue
  end
end
