require "csv"

namespace :import_invoices_csv do
  task create_invoices: :environment do
    csv_data = File.read("public/data/invoices.csv")
    csv = CSV.parse(csv_data, headers: true)
    csv.each do |row|
      Invoice.create!(row.to_hash)
    end
  end
end
