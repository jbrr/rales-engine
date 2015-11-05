require "test_helper"

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  attr_reader :merchant, :item, :invoice

  def setup
    @merchant = Merchant.create(id: 1, name: "Rocky")
    @item = Item.create(id: 5, merchant_id: 1)
    @invoice = Invoice.create(id: 4,
                              merchant_id: 1,
                              customer_id: 4,
                              created_at: "Sun, 25 Mar 2012 09:54:09 UTC +00:00")
    Invoice.create(id: 7,
                   merchant_id: 1,
                   customer_id: 4,
                   created_at: "Sun, 26 Mar 2012 09:55:09 UTC +00:00")
    Invoice.create(id: 8,
                   merchant_id: 1,
                   customer_id: 5)
    @transaction = Transaction.create(id: 8,
                                      invoice_id: 4,
                                      result: "success")
    Transaction.create(id: 9, invoice_id: 7, result: "success")
    Transaction.create(id: 10, invoice_id: 8, result: "failed")
    @invoice_item = InvoiceItem.create(id: 9,
                                       invoice_id: 4,
                                       quantity: 7,
                                       unit_price: 8738)
    InvoiceItem.create(id: 36, invoice_id: 7, quantity: 8, unit_price: 4732)
    Customer.create(id: 4, first_name: "Jeff", last_name: "Ruane")
    Customer.create(id: 5, first_name: "pizza", last_name: "party")
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

  test "#invoices" do
    get :invoices, format: :json, id: merchant.id

    assert_response :success
    assert_equal invoice.id, json_response[0]["id"]
  end

  test "#revenue" do
    get :revenue, format: :json, id: merchant.id

    assert_response :success
    response = {"revenue" => "990.22"}
    assert_equal response, json_response
  end

  test "#revenue with date" do
    get :revenue, format: :json, id: merchant.id, date: "2012-03-26 09:55:09"

    assert_response :success
    response = {"revenue" => "378.56"}
    assert_equal response, json_response
  end

  test "#favorite_customer" do
    get :favorite_customer, format: :json, id: merchant.id

    assert_response :success
    assert_equal "Jeff", json_response["first_name"]
  end

  test "#customers_with_pending_invoices" do
    get :customers_with_pending_invoices, format: :json, id: merchant.id

    assert_response :success
    assert_equal "pizza", json_response[0]["first_name"]
  end
end
