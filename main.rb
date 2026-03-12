require_relative 'tree'

test = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15])

puts "==="
test.pretty_print
puts "==="

test.level_order.sort.each {|val| puts "#{val}"}