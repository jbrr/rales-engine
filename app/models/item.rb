class Item < ActiveRecord::Base
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def self.best_day(id)
    item = Item.find(id)
    best = item.invoices.successful_transactions.group('"invoices"."created_at"').sum("quantity * unit_price").max_by(&:last).first
    { best_day: best }
  end
end
