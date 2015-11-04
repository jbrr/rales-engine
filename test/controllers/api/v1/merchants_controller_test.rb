require "test_helper"

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  attr_reader :merchant, :item, :invoice

  def setup
    @merchant = Merchant.create(id: 1, name: "Rocky")
    @item = Item.create(id: 5, merchant_id: 1)
    @invoice = Invoice.create(id: 4, merchant_id: 1)
  end

  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#show" do
    get :show, format: :json, id: merchant.id

    assert_response :success
  end

  test "#find" do
    get :find, format: :json, name: merchant.name

    assert_response :success
    assert_equal merchant.id, json_response["id"]
  end

  test "#find_all" do
    get :find_all, format: :json, name: merchant.name

    assert_response :success
    assert_equal Array, json_response.class
    assert_equal merchant.id, json_response[0]["id"]
  end

  test "#items" do
    get :items, format: :json, id: merchant.id

    assert_response :success
    assert_equal item.id, json_response[0]["id"]
  end

  test "invoices" do
    get :invoices, format: :json, id: merchant.id

    assert_response :success
    assert_equal invoice.id, json_response[0]["id"]
  end
end
