# frozen_string_literal: true

# Node in a tree
class Node
  attr_accessor :value, :left_child, :right_child

  def initialize(value = nil, left_child = nil, right_child = nil)
    @value = value
    @left_child = left_child
    @right_child = right_child
  end

  def <=>(other)
    value <=> other.value
  end

  def leaf?
    left_child.nil? && right_child.nil?
  end
end
