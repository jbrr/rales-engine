class Item < ActiveRecord::Base
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def self.best_day(id)
    item = Item.find(id)
    best = item.invoice_items.successful_transactions.group("invoices.created_at").order("sum_quantity DESC").sum("quantity").first[0]
    { best_day: best }
  end
end
