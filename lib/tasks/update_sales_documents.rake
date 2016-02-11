
namespace :spree_sale_pricing do

  desc "Update product documents when SalePrice is disabled"
  task :update_product_documents, [:date] => :environment do |t, args|
    return "No ending date specified" if !args[:date]
    # assumption is that sales end at midnight of the following day
    beginning_date = Time.zone.parse(args[:date]).beginning_of_day 
    ending_date = beginning_date.end_of_day + 1.day
    sale_prices = Spree::SalePrice.where('(end_at >= ?) AND (end_at <= ?)', beginning_date, ending_date)
    sale_prices.each {|sale_price|  sale_price.refresh_product_document }
  end

end

