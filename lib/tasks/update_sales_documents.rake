
namespace :spree_sale_pricing do

  desc "Update product documents when SalePrice is disabled"
  task :update_product_documents => :environment do
    date_time = Time.zone.now.to_s(:db)
    sale_prices = Spree::SalePrice.where("(end_at <= ?) AND (enabled = 't')", date_time)
    Rails.logger.info "Spree::SalePrice updating #{sale_prices.count} records."
    sale_prices.each {|sale_price| sale_price.refresh_product_document }
  end

end

