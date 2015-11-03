require 'test_helper'

class InvoiceItemTest < ActiveSupport::TestCase
  attr_reader :invoice_item

  def setup
    @invoice_item = invoice_items(:one)
  end

  test "invoice item has an invoice" do
    assert invoice_item.methods.include?(:invoice)
  end

  test "invoice item has an item" do
    assert invoice_item.methods.include?(:item)
  end
end
