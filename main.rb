require_relative 'tree'

test = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15])

puts "==="
test.pretty_print
puts "==="

result = []
test.inorder {|val| result << val}
p result

result = []
test.preorder {|val| result << val}
p result

result = []
test.postorder {|val| result << val}
p result