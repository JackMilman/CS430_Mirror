#!usr/bin/env ruby
require_relative '../ast.rb'

include Ast

block1 = Block.new([
    Assignment.new(
        "var",
        Add.new(
            IntP.new(5),
            IntP.new(7)
        )
    )
])

(block1.statements).each{|statement| puts statement.inspect}