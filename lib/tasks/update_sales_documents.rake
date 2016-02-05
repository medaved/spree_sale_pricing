
namespace :spree_sale_pricing do

  desc "Update product documents when SalePrice is disabled"
  task :update_product_documents, [:date] => :environment do |t, args|
    return "No ending date specified" if !args[:date]
    # assumption is that sales ending date is in mst
    Time.zone = "Mountain Time (US & Canada)"
    # assumption is that sales end at midnight of the following day
    ending_date = TIme.zone.parse(args[:date]).beginning_of_day + 1.day
    sale_prices = Spree::SalePrice.where('end_at <= ?', ending_date)
    sale_prices.each {|sp|  sp.refresh_product_document }
  end

end

