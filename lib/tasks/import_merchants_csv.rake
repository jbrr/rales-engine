require "csv"

namespace :import_merchants_csv do
  task create_merchants: :environment do
    csv_data = File.read("public/data/merchants.csv")
    csv = CSV.parse(csv_data, headers: true)
    csv.each do |row|
      Merchant.create!(row.to_hash)
    end
  end
end
