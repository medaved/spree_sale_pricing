
namespace :spree_sale_pricing do

  desc "Update product documents when SalePrice is disabled"
  task :udpate_product_documents => :environment do

    sale_prices = Spree::SalePrice.where('(end_at >= ?) AND (end_at <= ?)', Time.now - 1.day, Time.now)
    sale_prices.each {|sp|  sp.refresh_product_document }
    #puts "#{sale_prices.count} documents"

  end

end

