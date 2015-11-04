require "test_helper"

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  attr_reader :invoice,
              :transaction,
              :invoice_item,
              :item,
              :customer,
              :merchant

  def setup
    @invoice = Invoice.create(id: 1,
                              customer_id: 6,
                              merchant_id: 7,
                              status: "shipped")
    @transaction = Transaction.create(id: 5, invoice_id: 1)
    @invoice_item = InvoiceItem.create(id: 9, invoice_id: 1, item_id: 18)
    @item = Item.create(id: 18)
    @customer = Customer.create(id: 6)
    @merchant = Merchant.create(id: 7)
  end

  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#show" do
    get :show, format: :json, id: invoice.id

    assert_response :success
  end

  test "#find" do
    get :find, format: :json, customer_id: invoice.customer_id

    assert_response :success
    assert_equal invoice.customer_id, json_response["customer_id"]
  end

  test "#find_all" do
    get :find_all, format: :json, customer_id: invoice.customer_id

    assert_response :success
    assert_equal Array, json_response.class
    assert_equal invoice.customer_id, json_response[0]["customer_id"]
  end

  test "#transactions" do
    get :transactions, format: :json, id: invoice.id

    assert_response :success
    assert_equal transaction.id, json_response[0]["id"]
  end

  test "#invoice_items" do
    get :invoice_items, format: :json, id: invoice.id

    assert_response :success
    assert_equal invoice_item.id, json_response[0]["id"]
  end

  test "#items" do
    get :items, format: :json, id: invoice.id

    assert_response :success
    assert_equal item.id, json_response[0]["id"]
  end

  test "#customer" do
    get :customer, format: :json, id: invoice.id

    assert_response :success
    assert_equal customer.id, json_response["id"]
  end

  test "#merchant" do
    get :merchant, format: :json, id: invoice.id

    assert_response :success
    assert_equal merchant.id, json_response["id"]
  end
end
