require_relative 'node'

class Tree
  attr_accessor :root, :queue
  def initialize(array)
    @root = nil
    @queue = Array.new
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

  def insert(value)
    current = @root
    done = false
    until done
      case value <=> current&.value
      when -1
        current.left = Node.new(value) if current.left.nil?
        current = current.left
      when 0
        done = true
      when 1
        current.right = Node.new(value) if current.right.nil?
        current = current.right
      end
    end
    nil
  end

  def delete(value)
    proxy = get_node(value)
    node_for_remove = proxy[0]
    previous_node = proxy[1]
    case node_for_remove.childs?
    when 0 then delete_leaf_node(node_for_remove, previous_node)
    when 1 then delete_onechild_node(node_for_remove, previous_node)
    when 2 then delete_twochild_node(node_for_remove, previous_node)
    end
    nil
  end

  def delete_leaf_node(current, previous)
    value = current.value
    previous.left = nil if previous.left == current
    previous.right = nil if previous.right == current
    value
  end

  def delete_onechild_node(current, previous)
    value = current.value
    next_node = current.left || current.right
    previous.left = next_node if previous.left == current
    previous.right = next_node if previous.right == current
    value
  end

  def delete_twochild_node(current, previous)
    puts "#delete_twochild ran"
    successor = find_inorder_successsor(current.right)
    successor.left = current.left
    successor.right = current.right
    if !previous.nil?
      previous.left = successor if previous.left == current
      previous.right = successor if previous.right == current
    else
      @root = successor
    end
  end

  def find_inorder_successsor(node)
    puts "#find_inorder ran"
    array_of_successors = get_tree_values(node).compact.sort
    puts "#get_tree_values DONE!"
    p array_of_successors
    successor = get_node(array_of_successors[0])
    puts "#get_node DONE!"
    case successor[0].childs?
    when 0 
      delete_leaf_node(successor[0], successor[1])
    when 1
      delete_onechild_node(successor[0], successor[1])
    when 2
      puts "There is a case where successor is also a 2child node. Suffer."
    end
    result = successor[0]
    result
  end

  def level_order
    return to_enum(:level_order) unless block_given?

    result = []
    @queue << @root
    until @queue.empty?
      result << queue_handler
    end

    result.each do |val|
      yield(val)
    end
    self
  end

  def queue_handler
    node = @queue.shift
    result = node.value
    @queue.push(node.left) if node.left
    @queue.push(node.right) if node.right
    result
  end

  def preorder #DLR
    return to_enum(:preorder) unless block_given?

    result = depth_first_traverse(@root, :dlr)
    result.each do |val|
      yield(val)
    end
    self
  end

  def inorder #LDR
    return to_enum(:preorder) unless block_given?

    result = depth_first_traverse(@root, :ldr)
    result.each do |val|
      yield(val)
    end
    self
  end

  def postorder #LRD
    return to_enum(:preorder) unless block_given?

    result = depth_first_traverse(@root, :lrd)
    result.each do |val|
      yield(val)
    end
    self
  end

  def depth_first_traverse(node, instruction)
    return [] if node.nil?

    array = []
    case instruction
    when :dlr
      array << node.value
      array += depth_first_traverse(node.left, :dlr)
      array += depth_first_traverse(node.right, :dlr)
    when :ldr
      array += depth_first_traverse(node.left, :ldr)
      array << node.value
      array += depth_first_traverse(node.right, :ldr)
    when :lrd
      array += depth_first_traverse(node.left, :lrd)
      array += depth_first_traverse(node.right, :lrd)
      array << node.value
    end
    array
  end

  def get_tree_values(node)
    return [] if node == nil
    result = []
    result << node.value
    result += get_tree_values(node.left)
    result += get_tree_values(node.right)
    result
  end

  def get_node(value)
    result = nil
    previous = nil
    result = [@root, nil] if value == @root.value
    current = @root
    until result || current.nil?
      case value <=> current&.value
      when -1 then previous, current = current, current.left
      when 0 then result = [current, previous]
      when 1 then previous, current = current, current.right
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

