require "csv"

namespace :import_items_csv do
  task create_items: :environment do
    csv_data = File.read("public/data/items.csv")
    csv = CSV.parse(csv_data, headers: true)
    csv.each do |row|
      Item.create!(row.to_hash)
    end
  end
end
