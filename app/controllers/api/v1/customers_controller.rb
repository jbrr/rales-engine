class Api::V1::CustomersController < ApplicationController
  responds_to :json

  def index
    responds_with Customer.all
  end

  def show
    responds_with Customer.find(params[:id])
  end

  def create
    responds_with Customer.create(customer_params)
  end

  def update
    responds_with Customer.update(params[:id], customer_params)
  end

  def destroy
    responds_with Customer.destroy(params[:id])
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name)
  end
end
