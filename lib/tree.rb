# frozen_string_literal: true

require_relative 'node'

# My balanced binary tree
class Tree
  attr_accessor :root

  def initialize(elements)
    @root = build_tree(elements.sort.uniq)
  end

  def build_tree(elements)
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
end
