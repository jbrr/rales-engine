class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices

  def revenue(params)
    if params[:date]
      rev = invoices.where(created_at: params[:date]).successful_transactions.joins(:invoice_items).sum("unit_price * quantity")
    else
      rev = successful_invoices.joins(:invoice_items).sum("unit_price * quantity")
    end
    revenue_format(rev)
  end

  def favorite_customer
    customer_id = successful_invoices.group_by(&:customer_id).max_by { |k, v| v.count }.flatten.first
    Customer.find(customer_id)
  end

  def pending_customers
    invoices.pending_transactions.map(&:customer).uniq
  end

  def revenue_format(revenue)
    { revenue: (revenue.to_f / 100).to_s }
  end

  def successful_invoices
    invoices.successful_transactions
  end
end
