class Node
  attr_accessor :value, :left, :right
  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

  def childs?
    result = 1
    result = 2 if self.left && self.right
    result = 0 if !self.left && !self.right
    result
  end
end