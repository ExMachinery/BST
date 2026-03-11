require_relative 'node'

class Tree
  attr_accessor :root
  def initialize(array)
    @root = nil
    build_tree(array.uniq.sort)
  end

  def build_tree(array)
    return nil if array.empty?
    array_mid = (array.size - 1) / 2
    left_part = array[0...array_mid]
    right_part = array[array_mid+1..]

    current = nil
    if !@root
      @root = Node.new(array[array_mid])
      current = @root
    else
      current = Node.new(array[array_mid])
    end
    current.left = build_tree(left_part)
    current.right = build_tree(right_part)
    current
  end

  def include?(value)
    current = @root
    result = false
    until result || current.nil?
      case value <=> current&.value
      when -1 then current = current.left
      when 0 then result = true
      when 1 then current = current.right
      end
    end
    result
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    return unless node

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false)
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true)
  end

end

