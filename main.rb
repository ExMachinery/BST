require_relative 'tree'

test = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9])
# test.include?(9)
# test.include?(22)
# test.insert(15)
# test.insert(11)
puts "==="
test.pretty_print
puts "==="
test.delete(9)
puts "==="
test.pretty_print
puts "==="
test.delete(3)
puts "==="
test.pretty_print
puts "==="