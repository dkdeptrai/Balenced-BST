# frozen_string_literal: true

require_relative 'lib/tree'
require_relative 'lib/node'
arr = []
20.times { arr << rand(1..500) }
my_tree = Tree.new(arr)
my_tree.pretty_print
my_tree.delete(6)
my_node = my_tree.find(655)
my_tree.pretty_print
p my_tree.height(my_node)
