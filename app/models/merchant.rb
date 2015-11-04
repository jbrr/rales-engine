class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices

  def self.revenue(id)
    merchant = Merchant.find(id)
    rev = merchant.invoices.successful_transactions.joins(:invoice_items).sum("unit_price * quantity")
    revenue_format = (rev.to_f / 100).to_s
    { revenue: revenue_format }
  end
end
