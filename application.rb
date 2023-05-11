#!/usr/bin/ruby

require_relative "./order.rb"
puts "Enter your order below:"
input = STDIN.gets.chomp
puts "\n"
puts Order.new(input).run
