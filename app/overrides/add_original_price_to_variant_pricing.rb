Deface::Override.new(virtual_path: "spree/shared/_variant_pricing",
                     name: "add_original_price_to_variant_pricing",
                     replace_contents: ".detailed-spotlight-price",
                     partial: "spree/shared/original_price_display_variant",
                     disabled: false)