require "test_helper"

class Api::V1::InvoicesControllerTest < ActionController::TestCase
  attr_reader :invoice

  def setup
    @invoice = invoices(:one)
  end

  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#show" do
    get :show, format: :json, id: invoice.id

    assert_response :success
  end
end
