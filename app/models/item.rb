class Item < ActiveRecord::Base
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def best_day
    invoices.successful_transactions.group('"invoices"."created_at"')
      .order("sum_quantity DESC").sum("quantity").first[0]
  end
end
