
namespace :spree_sale_pricing do

  desc "Update product documents when SalePrice ends and disable SalePrice"
  task :update_product_documents => :environment do
    date_time = Time.zone.now.to_s(:db)
    sale_prices = Spree::SalePrice.where("(end_at <= ?) AND (enabled = 't')", date_time)
    Rails.logger.info "Spree::SalePrice updating #{sale_prices.count} records."
    # need to disable the sale_price so it won't keep refreshing every sale_price that has expired which will just get bigger
    sale_prices.each {|sale_price| sale_price.disable; sale_price.refresh_product_document }
  end

end

