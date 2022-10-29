# frozen_string_literal: true

require_relative 'lib/tree'
require_relative 'lib/node'

my_tree = Tree.new([3, 3, 655, 2, 1, 6, 2, 4, 7, 23, 124])
my_tree.pretty_print
