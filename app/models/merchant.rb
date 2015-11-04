class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices

  def self.revenue(params)
    merchant = Merchant.find(params[:id])
    if params[:date]
      rev = merchant.invoices.where(created_at: params[:date]).successful_transactions.joins(:invoice_items).sum("unit_price * quantity")
    else
      rev = merchant.invoices.successful_transactions.joins(:invoice_items).sum("unit_price * quantity")
    end
    revenue_format = (rev.to_f / 100).to_s
    { revenue: revenue_format }
  end

  def self.favorite_customer(id)
    merchant = Merchant.find(id)
    customer_id = merchant.invoices.successful_transactions.group_by(&:customer_id).max_by { |k, v| v.count }.flatten.first
    Customer.find(customer_id)
  end
end
