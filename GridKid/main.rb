#!usr/bin/env ruby
require 'curses'
require_relative './ast.rb'
require_relative './interp.rb'
require_relative './interface.rb'
require_relative 'ast_tests/arithmetic_tests.rb'
require_relative 'ast_tests/bitwise_tests.rb'
require_relative 'ast_tests/logical_tests.rb'
require_relative 'ast_tests/primitive_tests.rb'
require_relative 'ast_tests/cell_tests.rb'

include Ast
include Curses
include Interface

eval = Ast::Evaluator.new
ser = Ast::Serializer.new

# puts
# puts "------PRIMITIVE SERIALIZATION TESTS------"
# PrimitiveTests::Test.new.run_tests_serial(ser, Ast::Runtime.new)
# puts

# puts "------PRIMITIVE EVALUATION TESTS------"
# PrimitiveTests::Test.new.run_tests_eval(eval, ser, Ast::Runtime.new)
# puts

# puts "------ARITHMETIC SERIALIZATION TESTS------"
# ArithTests::Test.new.run_tests_serial(ser, Ast::Runtime.new)
# puts

# puts "------ARITHMETIC EVALUATION TESTS------"
# ArithTests::Test.new.run_tests_eval(eval, ser, Ast::Runtime.new)
# puts

# puts "------BITWISE SERIALIZATION TESTS------"
# BitwiseTests::Test.new.run_tests_serial(ser, Ast::Runtime.new)
# puts

# puts "------BITWISE EVALUATION TESTS------"
# BitwiseTests::Test.new.run_tests_eval(eval, ser, Ast::Runtime.new)
# puts

# puts "------LOGICAL SERIALIZATION TESTS------"
# LogicalTests::Test.new.run_tests_serial(ser, Ast::Runtime.new)
# puts

# puts "------CELL SERIALIZATION TESTS------"
# CellTests::Test.new.run_tests_serial(ser, Ast::Runtime.new)
# puts

# puts "------CELL EVALUATION TESTS------"
# CellTests::Test.new.run_tests_eval(eval, ser, Ast::Runtime.new(3))

init_screen

prog = Program.new
prog.main_loop

close_screen