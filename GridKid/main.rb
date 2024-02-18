#!usr/bin/env ruby
require_relative './ast.rb'
require_relative './arithmetic_tests.rb'
require_relative './bitwise_tests.rb'
require_relative './logical_tests.rb'
require_relative './primitive_tests.rb'
require_relative './cell_tests.rb'

eval = Ast::Evaluator.new
ser = Ast::Serializer.new
runtime = Ast::Runtime.new

# puts
# puts "------PRIMITIVE SERIALIZATION TESTS------"
# PrimitiveTests::Test.new.run_tests_serial(ser, runtime)
# puts
# puts "------PRIMITIVE EVALUATION TESTS------"
# PrimitiveTests::Test.new.run_tests_eval(eval, ser, runtime)
# puts
# puts "------ARITHMETIC SERIALIZATION TESTS------"
# ArithTests::Test.new.run_tests_serial(ser, runtime)
# puts
# puts "------ARITHMETIC EVALUATION TESTS------"
# ArithTests::Test.new.run_tests_eval(eval, ser, runtime)
# puts
# puts "------BITWISE SERIALIZATION TESTS------"
# BitwiseTests::Test.new.run_tests_serial(ser, runtime)
# puts
# puts "------BITWISE EVALUATION TESTS------"
# BitwiseTests::Test.new.run_tests_eval(eval, ser, runtime)
# puts
# puts "------CELL SERIAL TESTS------"
# CellTests::Test.new.run_tests_serial(ser, runtime)
puts
puts "------CELL EVALUATION TESTS------"
CellTests::Test.new.run_tests_eval(eval, ser, runtime)