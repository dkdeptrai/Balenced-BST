# frozen_string_literal: true

require_relative 'lib/tree'
require_relative 'lib/node'


my_tree = Tree.new(Array.new(15) { rand(1..100) })
p my_tree.balanced?
p my_tree.preorder
p my_tree.inorder
p my_tree.postorder
my_tree.insert(140)
my_tree.insert(200)
my_tree.insert(300)
my_tree.insert(600)
p my_tree.balanced?
my_tree.rebalence
my_tree.pretty_print
p my_tree.balanced?
p my_tree.preorder
p my_tree.inorder
p my_tree.postorder