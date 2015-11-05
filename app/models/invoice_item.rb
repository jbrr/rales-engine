class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :item

  def self.successful_transactions
    joins(:invoice).merge(Invoice.successful_transactions)
  end
end
