# frozen_string_literal: true

require_relative 'node'

# My balanced binary tree
class Tree
  attr_accessor :root

  def initialize(elements)
    @root = build_tree(elements)
  end

  def build_tree(elements)
    elements = elements.sort.uniq
    return nil if elements.empty?

    mid = (elements.length - 1) / 2
    root = Node.new(elements[mid])
    root.left_child = build_tree(elements[0...mid])
    root.right_child = build_tree(elements[mid + 1..])

    root
  end

  def pretty_print(node = root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def insert(value, node = root)
    if value < node.value
      node.left_child ? insert(value, node.left_child) : node.left_child = Node.new(value)
    elsif value > node.value
      node.right_child ? insert(value, node.right_child) : node.right_child = Node.new(value)
    end
    node
  end

  def min_node(node)
    result = Node.new
    until node.nil?
      result = node
      node = node.left_child
    end
    result
  end

  def delete(value, node = root)
    return nil if node.nil?

    if value < node.value
      node.left_child = delete(value, node.left_child)
    elsif value > node.value
      node.right_child = delete(value, node.right_child)
    else
      return node.right_child if node.left_child.nil?

      return node.left_child if node.right_child.nil?

      temp = min_node(node.right_child)
      node.value = temp.value
      node.right_child = delete(temp.value, node.right_child)
    end
    node
  end

  def find(value, node = root)
    return node if node.nil? || node.value == value

    value < node.value ? find(value, node.left_child) : find(value, node.right_child)
  end

  def level_order
    queue = [@root]
    result = []
    
    until queue.empty?
      node = queue.shift
      block_given? ? yield(node.value) : result << node.value

      queue.push(node.left_child) unless node.left_child.nil?
      queue.push(node.right_child) unless node.right_child.nil?
    end

    return result unless block_given?
  end

  def inorder(res = [], node = root, &block)
    return node if node.nil?

    inorder(res, node.left_child, &block)
    res.push(block_given? ? block.call(node.value) : node.value)
    inorder(res, node.right_child, &block)

    return res unless block_given?
  end

  def preorder(res = [], node = root, &block)
    return node if node.nil?

    res.push(block_given? ? block.call(node.value) : node.value)
    preorder(res, node.left_child, &block)
    preorder(res, node.right_child, &block)

    return res unless block_given?
  end

  def postorder(res = [], node = root, &block)
    return node if node.nil?

    preorder(res, node.left_child, &block)
    preorder(res, node.right_child, &block)
    res.push(block_given? ? block.call(node.value) : node.value)

    return res unless block_given?
  end

  def height(target, node = root, cur_height = 0)
    return cur_height if target == node
    return cur_height - 1 if node.nil?

    [height(target, node.left_child, cur_height + 1), height(target, node.right_child, cur_height + 1)].max
  end
end
