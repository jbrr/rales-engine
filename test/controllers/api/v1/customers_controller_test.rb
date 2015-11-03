require "test_helper"

class Api::V1::CustomersControllerTest < ActionController::TestCase
  attr_reader :customer

  def setup
    @customer = customers(:one)
  end
  
  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#index returns the right number of objects" do
    number_of_customers = Customer.count

    get :index, format: :json

    json_response = JSON.parse(response.body)

    assert_equal number_of_customers, json_response.count
  end

  test "#show" do
    get :show, format: :json, id: customer.id

    assert_response :success
  end
end
