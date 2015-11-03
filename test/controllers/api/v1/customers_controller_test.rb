require "test_helper"

class Api::V1::CustomersControllerTest < ActionController::TestCase
  attr_reader :customer, :invoice, :transaction

  def setup
    @customer = customers(:one)
    @invoice = Invoice.create(id: 5, customer_id: customer.id)
    @transaction = Transaction.create(id: 3, invoice_id: invoice.id)
  end

  def json_response
    JSON.parse(response.body)
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
    assert_equal customer.first_name, json_response["first_name"]
  end

  test "#find" do
    get :find, format: :json, first_name: customer.first_name

    assert_response :success
    assert_equal customer.first_name, json_response["first_name"]
  end

  test "#find_all" do
    get :find_all, format: :json, first_name: customer.first_name

    assert_response :success
    assert_equal Array, json_response.class
    assert_equal customer.first_name, json_response[0]["first_name"]
  end

  test "#invoices" do
    get :invoices, format: :json, id: customer.id

    assert_response :success
    assert_equal invoice.id, json_response[0]["id"]
  end

  test "#transactions" do
    get :transactions, format: :json, id: customer.id

    assert_response :success
    assert_equal transaction.id, json_response[0]["id"]
  end
end
