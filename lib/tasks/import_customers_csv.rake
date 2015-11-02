require "csv"

namespace :import_customers_csv do
  task create_customers: :environment do
    csv_data = File.read("public/data/customers.csv")
    csv = CSV.parse(csv_data, headers: true)
    csv.each do |row|
      Customer.create!(row.to_hash)
    end
  end
end
