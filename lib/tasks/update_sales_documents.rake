
namespace :spree_sale_pricing do

  desc "Update product documents when SalePrice is disabled"
  task :udpate_product_documents => :environment do

    lookup_hours = ENV['SALE_PRICE_LOOKUP_HOURS'].to_i
    lookup_hours = lookup_hours == 0 ? 1.day : lookup_hours.hours

    sale_prices = Spree::SalePrice.where('(end_at >= ?) AND (end_at <= ?)', Time.now - lookup_hours, Time.now)
    sale_prices.each {|sp|  sp.refresh_product_document }
    #puts "#{sale_prices.count} documents"

  end

end

