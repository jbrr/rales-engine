require "test_helper"

class Api::V1::InvoiceItemsControllerTest < ActionController::TestCase
  attr_reader :invoice_item

  def setup
    @invoice_item = invoice_items(:one)
  end

  def json_response
    JSON.parse(response.body)
  end

  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#show" do
    get :show, format: :json, id: invoice_item.id

    assert_response :success
  end
end
