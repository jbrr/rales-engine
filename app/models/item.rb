class Item < ActiveRecord::Base
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def best_day
    best = invoices.successful_transactions.group('"invoices"."created_at"').sum("quantity * unit_price").max_by(&:last).first
    { best_day: best }
  end
end
