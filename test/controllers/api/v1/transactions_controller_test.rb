require "test_helper"

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  attr_reader :transaction, :invoice

  def setup
    @transaction = Transaction.create(id: 1,
                                      credit_card_number: "1234",
                                      invoice_id: 5)
    @invoice = Invoice.create(id: 5)
  end

  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#show" do
    get :show, format: :json, id: transaction.id

    assert_response :success
  end

  test "#find" do
    get :find,
        format: :json,
        credit_card_number: transaction.credit_card_number

    assert_response :success
    assert_equal transaction.id, json_response["id"]
  end

  test "#find_all" do
    get :find_all,
        format: :json,
        credit_card_number: transaction.credit_card_number

    assert_response :success
    assert_equal Array, json_response.class
    assert_equal transaction.id, json_response[0]["id"]
  end

  test "#invoice" do
    get :invoice, format: :json, id: transaction.id

    assert_response :success
    assert_equal invoice.id, json_response["id"]
  end
end
