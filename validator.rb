module Validator
  def validate_formats(post_order)
    valid_code?(post_order[1])
  end

  def valid_code?(key)
    if Format::BUNDLES.keys.include?(key)
      true
    else
      puts "*** Invalid Code Format: #{key}.***\n\n" and return
    end
  end

  def valid_order_range?(input, highest_order_limit, format_code)
    if input < highest_order_limit
      true
    else
      puts "Order out of range. Order for #{format_code} should not greater than #{highest_order_limit}." and return
    end
  end
end
