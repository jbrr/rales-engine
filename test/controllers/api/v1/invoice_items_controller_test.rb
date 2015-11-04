require "test_helper"

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  attr_reader :invoice_item, :invoice, :item

  def setup
    @item = Item.create(id: 15)
    @invoice = Invoice.create(id: 4)
    @invoice_item = InvoiceItem.create(id: 3,
                                         invoice_id: invoice.id,
                                         item_id: item.id,
                                         quantity: 5)
  end

  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#show" do
    get :show, format: :json, id: invoice_item.id

    assert_response :success
    assert_equal invoice_item.quantity, json_response["quantity"]
  end

  test "#find" do
    get :find, format: :json, quantity: invoice_item.quantity

    assert_response :success
    assert_equal invoice_item.quantity, json_response["quantity"]
  end

  test "#find_all" do
    get :find_all, format: :json, quantity: invoice_item.quantity

    assert_response :success
    assert_equal Array, json_response.class
    assert_equal invoice_item.quantity, json_response[0]["quantity"]
  end

  test "#invoice" do
    get :invoice, format: :json, id: invoice_item.id

    assert_response :success
    assert_equal invoice.id, json_response["id"]
  end

  test "#item" do
    get :item, format: :json, id: invoice_item.id

    assert_response :success
    assert_equal item.id, json_response["id"]
  end
end
