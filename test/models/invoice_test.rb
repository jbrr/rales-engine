require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  attr_reader :invoice

  def setup
    @invoice = invoices(:one)
  end

  test "invoice has a customer" do
    assert invoice.methods.include?(:customer)
  end

  test "invoice has a merchant" do
    assert invoice.methods.include?(:merchant)
  end

  test "invoice has transactions" do
    assert invoice.methods.include?(:transactions)
  end

  test "invoice has invoice items" do
    assert invoice.methods.include?(:invoice_items)
  end

  test "invoice has items" do
    assert invoice.methods.include?(:items)
  end
end
