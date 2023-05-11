require_relative "./format.rb"
require_relative "./display_helper.rb"
require_relative "./validator.rb"

class Computation
  include Format
  include DisplayHelper
  include Validator

  def initialize(bundles, input, format_code)
    @bundles = bundles
    @input = input
    @old_input = input
    @format_code = format_code
  end

  def compute_and_print
    compute(@bundles, @input, @format_code, @old_input)
  end

  private

  def compute(bundles, input, format_code, old_input)
    ans = []
    bundles.each do |b|
      (1..(bundles.count)).each do |i|
        ans << b * i
        return print_conversion(b, b, i, 0, input, format_code, old_input) if input == (b * i)
        bundles.each do |b2|
          ans << (b*i) + (b2*i)
          return print_conversion(b, b2, i, i, input, format_code, old_input) if input == ((b*i) + (b2*i))
          (1..(bundles.count)).each do |i2|
            ans << (b*i) + (b2*i2)
            ans << (b*i2) + (b2*i)
            ans << (b*i) + (b2*i)
            ans << (b*i2) + (b2*i2)
            return print_conversion(b, b2, i, i2, input, format_code, old_input) if input == ((b*i) + (b2*i2))
            return print_conversion(b, b2, i2, i, input, format_code, old_input) if input == ((b*i2) + (b2*i))
            return print_conversion(b, b2, i, i, input, format_code, old_input) if input == ((b*i) + (b2*i))
            return print_conversion(b, b2, i2, i2, input, format_code, old_input) if input == ((b*i2) + (b2*i2))
          end
        end
      end
    end

    highest_order_limit = ans.uniq.sort.last
    if valid_order_range?(input, highest_order_limit, format_code)
      return self.compute(bundles, input+1, format_code, old_input)
    end
  end
end
