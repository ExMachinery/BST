require_relative 'tree'

test = Tree.new(Array.new(15) {rand(1..100)})
test.balanced?
arr = []
test.preorder {|val| arr << val}
p arr

arr = []
test.inorder {|val| arr << val}
p arr

arr = []
test.postorder {|val| arr << val}
p arr

test.insert(112)
test.insert(171)
test.insert(122)

test.balanced?
test.rebalance
test.balanced?

arr = []
test.preorder {|val| arr << val}
p arr

arr = []
test.inorder {|val| arr << val}
p arr

arr = []
test.postorder {|val| arr << val}
p arr

puts "==="
test.pretty_print
puts "==="
