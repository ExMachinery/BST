require_relative 'tree'

test = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15])

test.balanced?
test.insert(18)
test.insert(20)
test.insert(22)
puts "==="
test.pretty_print
puts "==="
test.balanced?
test.rebalance
puts "==="
test.pretty_print
puts "==="
test.balanced?
