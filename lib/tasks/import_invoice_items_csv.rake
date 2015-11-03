require "csv"

namespace :import_invoice_items_csv do
  task create_invoice_items: :environment do
    csv_data = File.read("public/data/invoice_items.csv")
    csv = CSV.parse(csv_data, headers: true)
    csv.each do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end
end
