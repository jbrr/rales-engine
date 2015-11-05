class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices

  def self.revenue(params)
    merchant = Merchant.find(params[:id])
    if params[:date]
      rev = merchant.invoices.where(created_at: params[:date]).successful_transactions.joins(:invoice_items).sum("unit_price * quantity")
    else
      rev = successful_invoices(merchant).joins(:invoice_items).sum("unit_price * quantity")
    end
    revenue_format(rev)
  end

  def self.favorite_customer(id)
    merchant = Merchant.find(id)
    customer_id = successful_invoices(merchant).group_by(&:customer_id).max_by { |k, v| v.count }.flatten.first
    Customer.find(customer_id)
  end

  def self.pending_customers(id)
    merchant = Merchant.find(id)
    merchant.invoices.pending_transactions.map(&:customer).uniq
  end

  def self.revenue_format(revenue)
    { revenue: (revenue.to_f / 100).to_s }
  end

  def self.successful_invoices(merchant)
    merchant.invoices.successful_transactions
  end
end
