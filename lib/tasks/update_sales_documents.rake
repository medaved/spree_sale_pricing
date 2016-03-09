
namespace :spree_sale_pricing do

  desc "Update product documents when SalePrice is disabled"
  task :update_product_documents, [:date] => :environment do |t, args|
    return "No ending date specified" if !args[:date]
    # assumption is that sales end at midnight of the following day
    date_time = Time.zone.parse(args[:date_time])
    sale_prices = Spree::SalePrice.where("(end_at <= ?) AND (enabled = 't')", date_time)
    sale_prices.each {|sale_price| sale_price.disable; sale_price.refresh_product_document }
  end

end

