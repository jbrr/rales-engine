require "test_helper"

class Api::V1::ItemsControllerTest < ActionController::TestCase
  attr_reader :item, :invoice_item, :merchant

  def setup
    @item = Item.create(id: 1, merchant_id: 5, name: "stuff")
    @invoice_item = InvoiceItem.create(id: 4, item_id: 1)
    @merchant = Merchant.create(id: 5)
  end

  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#show" do
    get :show, format: :json, id: item.id

    assert_response :success
  end

  test "#find" do
    get :find, format: :json, name: item.name

    assert_response :success
    assert_equal item.id, json_response["id"]
  end

  test "#find_all" do
    get :find_all, format: :json, name: item.name

    assert_response :success
    assert_equal Array, json_response.class
    assert_equal item.id, json_response[0]["id"]
  end

  test "#invoice_items" do
    get :invoice_items, format: :json, id: item.id

    assert_response :success
    assert_equal invoice_item.id, json_response[0]["id"]
  end

  test "#merchant" do
    get :merchant, format: :json, id: item.id

    assert_response :success
    assert_equal merchant.id, json_response["id"]
  end
end
