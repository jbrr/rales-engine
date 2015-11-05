require "test_helper"

class Api::V1::ItemsControllerTest < ActionController::TestCase
  attr_reader :item, :invoice_item, :merchant

  def setup
    @item = Item.create(id: 1, merchant_id: 5, name: "stuff", unit_price: 4372)
    @invoice_item = InvoiceItem.create(id: 4, item_id: 1, invoice_id: 4, quantity: 5)
    InvoiceItem.create(id: 5, item_id: 1, invoice_id: 5, quantity: 8)
    Invoice.create(id: 4, created_at: "Tue, 27 Mar 2012 14:54:09 UTC +00:00")
    Invoice.create(id: 5, created_at: "Tue, 27 Mar 2012 14:54:09 UTC +00:00")
    Transaction.create(id: 9, invoice_id: 4, result: "success")
    Transaction.create(id: 10, invoice_id: 5, result: "success")
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

  test "#find with unit_price" do
    get :find, format: :json, unit_price: "43.72"

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

  test "#best_day" do
    get :best_day, format: :json, id: item.id

    assert_response :success
    response = {"best_day"=>"2012-03-27T14:54:09.000Z"}
    assert_equal response, json_response
  end
end
