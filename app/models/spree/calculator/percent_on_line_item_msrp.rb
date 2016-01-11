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