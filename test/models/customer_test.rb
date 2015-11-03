require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  attr_reader :customer

  def setup
    @customer = customers(:one)
  end

    test "a customer has invoices" do
    assert customer.methods.include?(:invoices)
  end

  test "a customer has transactions" do
    assert customer.methods.include?(:transactions)
  end
end
