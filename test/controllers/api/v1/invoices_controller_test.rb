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
    @transaction = Transaction.create(id: 5, invoice_id: invoice.id)
    @invoice_item = InvoiceItem.create(id: 9, invoice_id: invoice.id)
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
end
