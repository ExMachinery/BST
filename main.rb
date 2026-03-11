require_relative 'tree'

test = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9])
test.include?(9)
test.include?(22)
