require "test_helper"

class Api::V1::MerchantsControllerTest < ActionController::TestCase
  attr_reader :merchant

  def setup
    @merchant = merchants(:one)
  end

  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#show" do
    get :show, format: :json, id: merchant.id

    assert_response :success
  end
end
