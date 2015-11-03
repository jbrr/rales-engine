require "test_helper"

class Api::V1::ItemsControllerTest < ActionController::TestCase
  attr_reader :item

  def setup
    @item = items(:one)
  end

  test "#index" do
    get :index, format: :json

    assert_response :success
  end

  test "#show" do
    get :show, format: :json, id: item.id

    assert_response :success
  end
end
