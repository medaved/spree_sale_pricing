module Spree
  class Calculator
    class PercentOnLineItemMsrp < Calculator
      preference :percent, :decimal, default: 0

      def self.description
        Spree.t(:percent_per_item_msrp)
      end

      def compute(object)
        
        variant = object.variant
        sale_percent = 0

          if variant.msrp.present? && (variant.msrp.to_f > 0)
            sale_percent = ((1 - ((variant.price.instance_of?(BigDecimal) || variant.price.instance_of?(Float)) ? variant.price.to_f : variant.price.amount.to_f) / variant.msrp.to_f) * 100).round
          end
          if preferred_percent < sale_percent
            return 0
          end
        ((variant.msrp * object.quantity) * (preferred_percent - sale_percent)) / 100
      end
    end
  end
end





      # def compute(object)
      #   return unless variant.msrp.present? && (variant.msrp.to_f > 0)
      #   variant = object.variant
      #     sale_percent = ((1 - ((variant.price.instance_of?(BigDecimal) || variant.price.instance_of?(Float)) ? variant.price.to_f : variant.price.amount.to_f) / variant.msrp.to_f) * 100).round
      #   if preferred_percent < sale_percent
      #     return 0
      #   end
      #   (variant.msrp * (preferred_percent - sale_percent)) / 100
      #   end
      # end

# def compute(object)
#         return 0 if object.nil?
#         #variant = object.variant
#         object.variants.reduce(0) do |sum, variant|
#           if variant.msrp.present? && (variant.msrp.to_f > 0)
#             sale_percent = ((1 - ((variant.price.instance_of?(BigDecimal) || variant.price.instance_of?(Float)) ? variant.price.to_f : variant.price.amount.to_f) / variant.msrp.to_f) * 100).round
#           end
#           if preferred_percent < sale_percent
#             return 0
#           end
#         sum +=(variant.msrp * (preferred_percent - sale_percent)) / 100
#         end
#       end  
