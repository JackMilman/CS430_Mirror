#!usr/bin/env ruby
require_relative './../ast.rb'

module PrimitiveTests
    class Test
        def run_tests_serial(visitor, runtime)
            int_tests(visitor, runtime)
            bool_tests(visitor, runtime)
            float_tests(visitor, runtime)
            string_tests(visitor, runtime)
            cell_address_tests(visitor, runtime)
        end

        def run_tests_eval(eval, ser, runtime)
            int_tests_eval(eval, ser, runtime)
            bool_tests_eval(eval, ser, runtime)
            float_tests_eval(eval, ser, runtime)
            string_tests_eval(eval, ser, runtime)
            cell_address_tests_eval(eval, ser, runtime)
        end

        def int_tests(ser, runtime)
            int1 = Ast::IntP.new(2)
            int2 = Ast::IntP.new(-2)
            intBad = Ast::IntP.new(4.5)
            int_result1 = int1.traverse(ser, runtime)
            puts "Int 1: #{int_result1}"
            int_result2 = int2.traverse(ser, runtime)
            puts "Int 2: #{int_result2}"
        end

        def bool_tests(ser, runtime)
            bool1 = Ast::BooleanP.new(true)
            bool2 = Ast::BooleanP.new(false)
            boolBad = Ast::BooleanP.new(3)
            bool_result1 = bool1.traverse(ser, runtime)
            puts "Bool 1: #{bool_result1}"
            bool_result2 = bool2.traverse(ser, runtime)
            puts "Bool 2: #{bool_result2}"
        end

        def float_tests(visitor, runtime)
            float1 = Ast::FloatP.new(2.0)
            float2 = Ast::FloatP.new(-2.7)
            floatBad1 = Ast::FloatP.new(false)
            floatBad2 = Ast::FloatP.new("blablabla")
            float_result1 = float1.traverse(visitor, runtime)
            puts "Float 1: #{float_result1}"
            float_result2 = float2.traverse(visitor, runtime)
            puts "Float 2: #{float_result2}"
        end

        def string_tests(visitor, runtime)
            string1 = Ast::StringP.new("hi ^_^")
            string2 = Ast::StringP.new("bye :(")
            bad_string1 = Ast::StringP.new(7)
            bad_string2 = Ast::StringP.new(false)
            string_result1 = string1.traverse(visitor, runtime)
            puts "String 1: #{string_result1}"
            string_result2 = string2.traverse(visitor, runtime)
            puts "String 2: #{string_result2}"
        end

        def cell_address_tests(visitor, runtime)
            cell_addr1 = Ast::CellAddressP.new(1, 2)
            cell_addr2 = Ast::CellAddressP.new(7, 0)
            bad_cell_addr1 = Ast::CellAddressP.new(true, 0)
            bad_cell_addr2 = Ast::CellAddressP.new(1, "^_^")
            addr_result1 = cell_addr1.traverse(visitor, runtime)
            puts "Address Primitive 1: #{addr_result1}"
            addr_result2 = cell_addr2.traverse(visitor, runtime)
            puts "Address Primitive 2: #{addr_result2}"
        end

        #---------------------------------------------------------------------#
        #---------------------------EVALUATOR TESTS---------------------------#
        #---------------------------------------------------------------------#
        def int_tests_eval(eval, ser, runtime)
            int1 = Ast::IntP.new(2)
            int2 = Ast::IntP.new(-2)
            intBad = Ast::IntP.new(4.5)
            int_result1 = int1.traverse(eval, runtime)
            puts "Int 1: #{int_result1.traverse(ser, runtime)}"
            int_result2 = int2.traverse(eval, runtime)
            puts "Int 2: #{int_result2.traverse(ser, runtime)}"
            begin
                int_resultBad = intBad.traverse(eval, runtime)
                puts "Int Bad: #{int_resultBad.traverse(ser, runtime)} Failed to detect"
            rescue TypeError
                puts "Bad Int detected (Float)"
            end
        end

        def bool_tests_eval(eval, ser, runtime)
            bool1 = Ast::BooleanP.new(true)
            bool2 = Ast::BooleanP.new(false)
            boolBad = Ast::BooleanP.new(3)
            bool_result1 = bool1.traverse(eval, runtime)
            puts "Bool 1: #{bool_result1.traverse(ser, runtime)}"
            bool_result2 = bool2.traverse(eval, runtime)
            puts "Bool 2: #{bool_result2.traverse(ser, runtime)}"
            begin
                bool_resultBad = boolBad.traverse(eval, runtime)
                puts "Bool Bad: #{bool_resultBad.traverse(ser, runtime)} Failed to detect"
            rescue TypeError
                puts "Bad Bool detected (Integer)"
            end
        end

        def float_tests_eval(eval, ser, runtime)
            float1 = Ast::FloatP.new(2.0)
            float2 = Ast::FloatP.new(-2.7)
            floatBad1 = Ast::FloatP.new(false)
            floatBad2 = Ast::FloatP.new("blablabla")
            float_result1 = float1.traverse(eval, runtime)
            puts "Float 1: #{float_result1.traverse(ser, runtime)}"
            float_result2 = float2.traverse(eval, runtime)
            puts "Float 2: #{float_result2.traverse(ser, runtime)}"
            begin
                float_resultBad1 = floatBad1.traverse(eval, runtime)
                puts "Float Bad1: #{float_resultBad1.traverse(ser, runtime)} Failed to detect"
            rescue TypeError
                puts "Bad Float 1 detected (Boolean)"
            end
            begin
                float_resultBad2 = floatBad2.traverse(eval, runtime)
                puts "Float Bad2: #{float_resultBad2.traverse(ser, runtime)} Failed to detect"
            rescue TypeError
                puts "Bad Float 2 detected (String)"
            end
        end

        def string_tests_eval(eval, ser, runtime)
            string1 = Ast::StringP.new("hi ^_^")
            string2 = Ast::StringP.new("bye :(")
            bad_string1 = Ast::StringP.new(7)
            bad_string2 = Ast::StringP.new(false)
            string_result1 = string1.traverse(eval, runtime)
            puts "String 1: #{string_result1.traverse(ser, runtime)}"
            string_result2 = string2.traverse(eval, runtime)
            puts "String 2: #{string_result2.traverse(ser, runtime)}"
            begin
                string_resultBad1 = bad_string1.traverse(eval, runtime)
                puts "String Bad1: #{string_resultBad1.traverse(ser, runtime)} Failed to detect"
            rescue TypeError
                puts "Bad String 1 detected (Integer)"
            end
            begin
                string_resultBad2 = bad_string2.traverse(eval, runtime)
                puts "String Bad2: #{string_resultBad2.traverse(ser, runtime)} Failed to detect"
            rescue TypeError
                puts "Bad String 2 detected (Boolean)"
            end
        end

        def cell_address_tests_eval(eval, ser, runtime)
            cell_addr1 = Ast::CellAddressP.new(1, 2)
            cell_addr2 = Ast::CellAddressP.new(7, 0)
            bad_cell_addr1 = Ast::CellAddressP.new(true, 0)
            bad_cell_addr2 = Ast::CellAddressP.new(1, "^_^")
            addr_result1 = cell_addr1.traverse(eval, runtime)
            puts "Address Primitive 1: #{addr_result1.traverse(ser, runtime)}"
            addr_result2 = cell_addr2.traverse(eval, runtime)
            puts "Address Primitive 2: #{addr_result2.traverse(ser, runtime)}"
            begin
                addr_resultBad1 = bad_cell_addr1.traverse(eval, runtime)
                puts "Address Primitive Bad1: #{addr_resultBad1.traverse(ser, runtime)} Failed to detect"
            rescue TypeError
                puts "Bad Address Primitive 1 detected (Boolean Left Operand)"
            end
            begin
                addr_resultBad2 = bad_cell_addr2.traverse(eval, runtime)
                puts "Address Primitive Bad2: #{addr_resultBad2.traverse(ser, runtime)} Failed to detect"
            rescue TypeError
                puts "Bad Address Primitive 2 detected (String Right Operand)"
            end
        end
    end
end