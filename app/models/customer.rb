class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchant_id = invoices.successful_transactions.group_by(&:merchant_id).max_by { |k, v| v.count }.flatten.first
    Merchant.find(merchant_id)
  end
end
