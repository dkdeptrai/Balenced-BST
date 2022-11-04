# frozen_string_literal: true

require_relative 'node'
# rubocop:disable ClassLength
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

  def depth(target, node = root, cur_depth = 0)
    return cur_depth if target == node
    return cur_depth - 1 if target.nil? || node.nil?

    [depth(target, node.left_child, cur_depth + 1), depth(target, node.right_child, cur_depth + 1)].max
  end

  def height(node, cur_height = 0)
    return -1 if node.nil?
    return cur_height if node.leaf?

    [height(node.left_child, cur_height + 1), height(node.right_child, cur_height + 1)].max
  end

  def balanced?(node = root)
    return false if node.nil?
    return true if (height(node.left_child) - height(node.right_child)).abs <= 1

    balanced?(node.left_child) && balanced?(node.right_child)
  end

  def rebalence
    arr = []
    inorder { |val| arr << val }
    @root = build_tree(arr)
  end
end
# rubocop:enable ClassLength
