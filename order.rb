require_relative "./computation.rb"
require_relative "./format.rb"
require_relative "./validator.rb"

class Order < Computation
  include Format
  include Validator

  def initialize(input)
    @input_array = input.split(" ")
  end

  def run
    while (post_order = @input_array.slice!(-2, 2))
      if validate_formats(post_order)
        puts compute(Format::BUNDLES[post_order[1]].keys, post_order[0].to_i, post_order[1], post_order[0].to_i)
      end
    end
  end
end
