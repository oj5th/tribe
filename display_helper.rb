require_relative "./validator.rb"

module DisplayHelper
  include Validator

  def print_conversion(b, b2, multiplicator_1, multiplicator_2, input, format_code, old_input)
    if b == b2
      offered_bundle_by_order(input, old_input)
      puts "#{input} #{format_code.upcase} $#{grand_total_one_bundle_per_order(format_code, b)}\n\t#{
              multiplicator_1 + multiplicator_2} x #{b} $#{
              compute_order_total_by_bundle(format_code, b, (multiplicator_1 + multiplicator_2))
            }" and return
    else
      offered_bundle_by_order(input, old_input)
      puts "#{input} #{format_code.upcase} $#{grand_total_multiple_bundle_per_order(format_code, b, b2, multiplicator_1, multiplicator_2)}\n\t#{
        multiplicator_1} x #{b} $#{(compute_order_total_by_bundle(format_code, b, multiplicator_1))}\n\t#{
        multiplicator_2} x #{b2} $#{(compute_order_total_by_bundle(format_code, b2, multiplicator_2))}" and return
    end
  end

  def compute_order_total_by_bundle(format_code, bundle, multiplicator=1)
    Format::BUNDLES[format_code][bundle] * multiplicator
  end

  def grand_total_one_bundle_per_order(format_code, b)
    compute_order_total_by_bundle(format_code, b)
  end

  def grand_total_multiple_bundle_per_order(format_code, b, b2, multiplicator_1, multiplicator_2)
    compute_order_total_by_bundle(format_code, b, multiplicator_1) + compute_order_total_by_bundle(format_code, b2, multiplicator_2)
  end

  def offered_bundle_by_order(input, old_input)
    puts "Order count: #{old_input}. Offered bundle #{input}." if input != old_input
  end
end
