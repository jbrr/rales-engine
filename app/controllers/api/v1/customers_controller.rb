class Api::V1::CustomersController < ApplicationController
  respond_to :json
  before_action :capitalize_params

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find(params[:id])
  end

  def find
    respond_with Customer.find_by(customer_params)
  end

  private

  def customer_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end

  def capitalize_params
    customer_params.values.each do |value|
      if value.class == String
        value.capitalize!
      end
    end
  end
end
