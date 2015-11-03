class Api::V1::InvoicesController < ApplicationController
  responds_to :json

  def index
    responds_with Invoice.all
  end

  def show
    responds_with Invoice.find(params[:id])
  end

  def create
    responds_with Invoice.create(invoice_params)
  end

  def update
    responds_with Invoice.update(params[:id], invoice_params)
  end

  def destroy
    responds_with Invoice.destroy(params[:id])
  end

  private

  def invoice_params
    params.require(:invoice).permit(:customer_id, :merchant_id, :status)
  end
end
