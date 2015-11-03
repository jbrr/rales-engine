require "test_helper"

class Api::V1::TransactionsControllerTest < ActionController::TestCase
  attr_reader :transaction

  def setup
    @transaction = transactions(:one)
  end

  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#show" do
    get :show, format: :json, id: transaction.id

    assert_response :success
  end
end
