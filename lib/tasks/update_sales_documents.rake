
namespace :spree_sale_pricing do

  desc "Update product documents when SalePrice is disabled"
  task :update_product_documents, [:date] => :environment do |t, args|
    return "No ending date specified" if !args[:date]

    date_time = Time.zone.at(args[:date_time].to_i)
    sale_prices = Spree::SalePrice.where("(end_at <= ?) AND (enabled = 't')", date_time)
    Rails.logger.info "Spree::SalePrice updating #{sale_prices.count} records."
    sale_prices.each {|sale_price| sale_price.refresh_product_document }
  end

end

