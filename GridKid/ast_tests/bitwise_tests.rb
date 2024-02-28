#!usr/bin/env ruby
require_relative './../ast.rb'

module BitwiseTests
    class Test
        def run_tests_serial(visitor, runtime)
            puts "---BIT AND---"
            bit_and_tests(visitor, runtime)
            puts
            puts "---BIT OR---"
            bit_or_tests(visitor, runtime)
            puts
            puts "---BIT XOR---"
            bit_xor_tests(visitor, runtime)
            puts
            puts "---BIT NOT---"
            bit_not_tests(visitor, runtime)
            puts
            puts "---BIT LEFT SHIFT---"
            bit_left_shift_tests(visitor, runtime)
            puts
            puts "---BIT RIGHT SHIFT---"
            bit_right_shift_tests(visitor, runtime)
        end

        def run_tests_eval(eval, ser, runtime)
            puts "---BIT AND---"
            bit_and_tests_eval(eval, ser, runtime)
            puts
            puts "---BIT OR---"
            bit_or_tests_eval(eval, ser, runtime)
            puts
            puts "---BIT XOR---"
            bit_xor_tests_eval(eval, ser, runtime)
            puts
            puts "---BIT NOT---"
            bit_not_tests_eval(eval, ser, runtime)
            puts
            puts "---BIT LEFT SHIFT---"
            bit_left_shift_tests_eval(eval, ser, runtime)
            puts
            puts "---BIT RIGHT SHIFT---"
            bit_right_shift_tests_eval(eval, ser, runtime)
        end

        def bit_and_tests(visitor, runtime)
            b_and1 = Ast::BitwiseAnd.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )
            b_and2 = Ast::BitwiseAnd.new(
                Ast::IntP.new(1),
                Ast::IntP.new(9),
            )
            b_and3 = Ast::BitwiseAnd.new(
                Ast::IntP.new(-5),
                Ast::IntP.new(2),
            )
            super_b_and = Ast::BitwiseAnd.new( # hee hee hee
                Ast::Add.new(
                    Ast::IntP.new(5),
                    Ast::IntP.new(5), 
                ),
                Ast::BitwiseAnd.new(
                    Ast::IntP.new(3),
                    Ast::IntP.new(2)
                )
            )
            result1 = b_and1.traverse(visitor, runtime)
            puts "Bitwise And 1: #{result1}"
            result2 = b_and2.traverse(visitor, runtime)
            puts "Bitwise And 2: #{result2}"
            result3 = b_and3.traverse(visitor, runtime)
            puts "Bitwise And 3: #{result3}"
            super_result = super_b_and.traverse(visitor, runtime)
            puts "Super Bitwise And: #{super_result}"
        end
        
        def bit_or_tests(visitor, runtime)
            var1 = Ast::BitwiseOr.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )
            var2 = Ast::BitwiseOr.new(
                Ast::IntP.new(1),
                Ast::IntP.new(9),
            )
            var3 = Ast::BitwiseOr.new(
                Ast::IntP.new(-5),
                Ast::IntP.new(2),
            )
            super_var = Ast::BitwiseOr.new( # hee hee hee
                Ast::Add.new(
                    Ast::IntP.new(5),
                    Ast::IntP.new(5), 
                ),
                Ast::BitwiseOr.new(
                    Ast::IntP.new(3),
                    Ast::IntP.new(2)
                )
            )
            result1 = var1.traverse(visitor, runtime)
            puts "Bitwise Or 1: #{result1}"
            result2 = var2.traverse(visitor, runtime)
            puts "Bitwise Or 2: #{result2}"
            result3 = var3.traverse(visitor, runtime)
            puts "Bitwise Or 3: #{result3}"
            super_result = super_var.traverse(visitor, runtime)
            puts "Super Bitwise Or: #{super_result}"
        end
        
        def bit_xor_tests(visitor, runtime)
            var1 = Ast::BitwiseXor.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )
            var2 = Ast::BitwiseXor.new(
                Ast::IntP.new(1),
                Ast::IntP.new(9),
            )
            var3 = Ast::BitwiseXor.new(
                Ast::IntP.new(-5),
                Ast::IntP.new(2),
            )
            super_var = Ast::BitwiseXor.new(
                Ast::Add.new(
                    Ast::IntP.new(5),
                    Ast::IntP.new(5), 
                ),
                Ast::BitwiseXor.new(
                    Ast::IntP.new(3),
                    Ast::IntP.new(2)
                )
            )
            result1 = var1.traverse(visitor, runtime)
            puts "Bitwise Xor 1: #{result1}"
            result2 = var2.traverse(visitor, runtime)
            puts "Bitwise Xor 2: #{result2}"
            result3 = var3.traverse(visitor, runtime)
            puts "Bitwise Xor 3: #{result3}"
            super_result = super_var.traverse(visitor, runtime)
            puts "Super Bitwise Xor: #{super_result}"
        end
        
        def bit_not_tests(visitor, runtime)
            var1 = Ast::BitwiseNot.new(Ast::IntP.new(1))
            var2 = Ast::BitwiseNot.new(Ast::IntP.new(9))
            var3 = Ast::BitwiseNot.new(Ast::IntP.new(-5))
            super_var = Ast::BitwiseNot.new(
                Ast::BitwiseNot.new(Ast::IntP.new(3))
            )
            result1 = var1.traverse(visitor, runtime)
            puts "Bitwise Not 1: #{result1}"
            result2 = var2.traverse(visitor, runtime)
            puts "Bitwise Not 2: #{result2}"
            result3 = var3.traverse(visitor, runtime)
            puts "Bitwise Not 3: #{result3}"
            super_result = super_var.traverse(visitor, runtime)
            puts "Super Bitwise Not: #{super_result}"
        end
        
        def bit_left_shift_tests(visitor, runtime)
            var1 = Ast::BitwiseLeftShift.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )
            var2 = Ast::BitwiseLeftShift.new(
                Ast::IntP.new(1),
                Ast::IntP.new(9),
            )
            var3 = Ast::BitwiseLeftShift.new(
                Ast::IntP.new(-5),
                Ast::IntP.new(2),
            )
            super_var = Ast::BitwiseLeftShift.new(
                Ast::Add.new(
                    Ast::IntP.new(5),
                    Ast::IntP.new(5), 
                ),
                Ast::BitwiseLeftShift.new(
                    Ast::IntP.new(3),
                    Ast::IntP.new(2)
                )
            )
            result1 = var1.traverse(visitor, runtime)
            puts "Bitwise Left Shift 1: #{result1}"
            result2 = var2.traverse(visitor, runtime)
            puts "Bitwise Left Shift 2: #{result2}"
            result3 = var3.traverse(visitor, runtime)
            puts "Bitwise Left Shift 3: #{result3}"
            super_result = super_var.traverse(visitor, runtime)
            puts "Super Bitwise Left Shift: #{super_result}"
        end
        
        def bit_right_shift_tests(visitor, runtime)
            var1 = Ast::BitwiseRightShift.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )
            var2 = Ast::BitwiseRightShift.new(
                Ast::IntP.new(1),
                Ast::IntP.new(9),
            )
            var3 = Ast::BitwiseRightShift.new(
                Ast::IntP.new(-5),
                Ast::IntP.new(2),
            )
            super_var = Ast::BitwiseRightShift.new(
                Ast::Add.new(
                    Ast::IntP.new(5),
                    Ast::IntP.new(5), 
                ),
                Ast::BitwiseRightShift.new(
                    Ast::IntP.new(3),
                    Ast::IntP.new(2)
                )
            )
            result1 = var1.traverse(visitor, runtime)
            puts "Bitwise Right Shift 1: #{result1}"
            result2 = var2.traverse(visitor, runtime)
            puts "Bitwise Right Shift 2: #{result2}"
            result3 = var3.traverse(visitor, runtime)
            puts "Bitwise Right Shift 3: #{result3}"
            super_result = super_var.traverse(visitor, runtime)
            puts "Super Bitwise Right Shift: #{super_result}"
        end
        #---------------------------------------------------------------------#
        #---------------------------EVALUATOR TESTS---------------------------#
        #---------------------------------------------------------------------#
        def bit_and_tests_eval(eval, ser, runtime)
            b_and1 = Ast::BitwiseAnd.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )
            b_and2 = Ast::BitwiseAnd.new(
                Ast::IntP.new(1),
                Ast::IntP.new(9),
            )
            b_and3 = Ast::BitwiseAnd.new(
                Ast::IntP.new(-5),
                Ast::IntP.new(2),
            )
            super_b_and = Ast::BitwiseAnd.new(
                Ast::Add.new(
                    Ast::IntP.new(5),
                    Ast::IntP.new(5), 
                ),
                Ast::BitwiseAnd.new(
                    Ast::IntP.new(3),
                    Ast::IntP.new(2)
                )
            )
            nickleback = Ast::BitwiseAnd.new(
                Ast::FloatP.new(2.5),
                Ast::IntP.new(12)
            )
            result1 = b_and1.traverse(eval, runtime)
            puts "Bitwise And 1: #{result1.traverse(ser, runtime)}"
            result2 = b_and2.traverse(eval, runtime)
            puts "Bitwise And 2: #{result2.traverse(ser, runtime)}"
            result3 = b_and3.traverse(eval, runtime)
            puts "Bitwise And 3: #{result3.traverse(ser, runtime)}"
            super_result = super_b_and.traverse(eval, runtime)
            puts "Super Bitwise And: #{super_result.traverse(ser, runtime)}"
            begin
              bad_result = nickleback.traverse(eval, runtime)
              puts "nickleback: MISSED AN ERROR Incompatible Operand"
            rescue TypeError
                puts "nickleback TypeError detected: music avoided (Incompatible Operand)"
            end
            
        end
        
        def bit_or_tests_eval(eval, ser, runtime)
            var1 = Ast::BitwiseOr.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )
            var2 = Ast::BitwiseOr.new(
                Ast::IntP.new(1),
                Ast::IntP.new(9),
            )
            var3 = Ast::BitwiseOr.new(
                Ast::IntP.new(-5),
                Ast::IntP.new(2),
            )
            super_var = Ast::BitwiseOr.new(
                Ast::Add.new(
                    Ast::IntP.new(5),
                    Ast::IntP.new(5), 
                ),
                Ast::BitwiseOr.new(
                    Ast::IntP.new(3),
                    Ast::IntP.new(2)
                )
            )
            bad_var = Ast::BitwiseOr.new(
                Ast::FloatP.new(2.5),
                Ast::IntP.new(12)
            )
            result1 = var1.traverse(eval, runtime)
            puts "Bitwise Or 1: #{result1.traverse(ser, runtime)}"
            result2 = var2.traverse(eval, runtime)
            puts "Bitwise Or 2: #{result2.traverse(ser, runtime)}"
            result3 = var3.traverse(eval, runtime)
            puts "Bitwise Or 3: #{result3.traverse(ser, runtime)}"
            super_result = super_var.traverse(eval, runtime)
            puts "Super Bitwise Or: #{super_result.traverse(ser, runtime)}"
            begin
                bad_result = bad_var.traverse(eval, runtime)
                puts "bad_var: MISSED AN ERROR Incompatible Operand"
            rescue TypeError
                puts "bad_var TypeError detected: Incompatible Operand"
            end
        end
        
        def bit_xor_tests_eval(eval, ser, runtime)
            var1 = Ast::BitwiseXor.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )
            var2 = Ast::BitwiseXor.new(
                Ast::IntP.new(1),
                Ast::IntP.new(9),
            )
            var3 = Ast::BitwiseXor.new(
                Ast::IntP.new(-5),
                Ast::IntP.new(2),
            )
            super_var = Ast::BitwiseXor.new(
                Ast::Add.new(
                    Ast::IntP.new(5),
                    Ast::IntP.new(5), 
                ),
                Ast::BitwiseXor.new(
                    Ast::IntP.new(3),
                    Ast::IntP.new(2)
                )
            )
            bad_var = Ast::BitwiseXor.new(
                Ast::FloatP.new(2.5),
                Ast::IntP.new(12)
            )
            result1 = var1.traverse(eval, runtime)
            puts "Bitwise Xor 1: #{result1.traverse(ser, runtime)}"
            result2 = var2.traverse(eval, runtime)
            puts "Bitwise Xor 2: #{result2.traverse(ser, runtime)}"
            result3 = var3.traverse(eval, runtime)
            puts "Bitwise Xor 3: #{result3.traverse(ser, runtime)}"
            super_result = super_var.traverse(eval, runtime)
            puts "Super Bitwise Xor: #{super_result.traverse(ser, runtime)}"
            begin
                bad_result = bad_var.traverse(eval, runtime)
                puts "bad_var: MISSED AN ERROR Incompatible Operand"
            rescue TypeError
                puts "bad_var TypeError detected: Incompatible Operand"
            end
        end
        
        def bit_not_tests_eval(eval, ser, runtime)
            var1 = Ast::BitwiseNot.new(Ast::IntP.new(1))
            var2 = Ast::BitwiseNot.new(Ast::IntP.new(9))
            var3 = Ast::BitwiseNot.new(Ast::IntP.new(-5))
            super_var = Ast::BitwiseNot.new(
                Ast::BitwiseNot.new(Ast::IntP.new(3))
            )
            bad_var = Ast::BitwiseNot.new(Ast::FloatP.new(2.5))
            result1 = var1.traverse(eval, runtime)
            puts "Bitwise Not 1: #{result1.traverse(ser, runtime)}"
            result2 = var2.traverse(eval, runtime)
            puts "Bitwise Not 2: #{result2.traverse(ser, runtime)}"
            result3 = var3.traverse(eval, runtime)
            puts "Bitwise Not 3: #{result3.traverse(ser, runtime)}"
            super_result = super_var.traverse(eval, runtime)
            puts "Super Bitwise Not: #{super_result.traverse(ser, runtime)}"
            begin
                bad_result = bad_var.traverse(eval, runtime)
                puts "bad_var: MISSED AN ERROR Incompatible Operand"
            rescue TypeError
                puts "bad_var TypeError detected: Incompatible Operand"
            end
        end
        
        def bit_left_shift_tests_eval(eval, ser, runtime)
            var1 = Ast::BitwiseLeftShift.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )
            var2 = Ast::BitwiseLeftShift.new(
                Ast::IntP.new(1),
                Ast::IntP.new(9),
            )
            var3 = Ast::BitwiseLeftShift.new(
                Ast::IntP.new(-5),
                Ast::IntP.new(2),
            )
            super_var = Ast::BitwiseLeftShift.new(
                Ast::Add.new(
                    Ast::IntP.new(5),
                    Ast::IntP.new(5), 
                ),
                Ast::BitwiseLeftShift.new(
                    Ast::IntP.new(3),
                    Ast::IntP.new(2)
                )
            )
            bad_var = Ast::BitwiseLeftShift.new(
                Ast::FloatP.new(2.5),
                Ast::IntP.new(12)
            )
            result1 = var1.traverse(eval, runtime)
            puts "Bitwise Left Shift 1: #{result1.traverse(ser, runtime)}"
            result2 = var2.traverse(eval, runtime)
            puts "Bitwise Left Shift 2: #{result2.traverse(ser, runtime)}"
            result3 = var3.traverse(eval, runtime)
            puts "Bitwise Left Shift 3: #{result3.traverse(ser, runtime)}"
            super_result = super_var.traverse(eval, runtime)
            puts "Super Bitwise Left Shift: #{super_result.traverse(ser, runtime)}"
            begin
                bad_result = bad_var.traverse(eval, runtime)
                puts "bad_var: MISSED AN ERROR Incompatible Operand"
            rescue TypeError
                puts "bad_var TypeError detected: Incompatible Operand"
            end
        end
        
        def bit_right_shift_tests_eval(eval, ser, runtime)
            var1 = Ast::BitwiseRightShift.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )
            var2 = Ast::BitwiseRightShift.new(
                Ast::IntP.new(1),
                Ast::IntP.new(9),
            )
            var3 = Ast::BitwiseRightShift.new(
                Ast::IntP.new(-5),
                Ast::IntP.new(2),
            )
            super_var = Ast::BitwiseRightShift.new(
                Ast::Add.new(
                    Ast::IntP.new(5),
                    Ast::IntP.new(5), 
                ),
                Ast::BitwiseRightShift.new(
                    Ast::IntP.new(3),
                    Ast::IntP.new(2)
                )
            )
            bad_var = Ast::BitwiseRightShift.new(
                Ast::FloatP.new(2.5),
                Ast::IntP.new(12)
            )
            result1 = var1.traverse(eval, runtime)
            puts "Bitwise Right Shift 1: #{result1.traverse(ser, runtime)}"
            result2 = var2.traverse(eval, runtime)
            puts "Bitwise Right Shift 2: #{result2.traverse(ser, runtime)}"
            result3 = var3.traverse(eval, runtime)
            puts "Bitwise Right Shift 3: #{result3.traverse(ser, runtime)}"
            super_result = super_var.traverse(eval, runtime)
            puts "Super Bitwise Right Shift: #{super_result.traverse(ser, runtime)}"
            begin
                bad_result = bad_var.traverse(eval, runtime)
                puts "bad_var: MISSED AN ERROR Incompatible Operand"
            rescue TypeError
                puts "bad_var TypeError detected: Incompatible Operand"
            end
        end
    end
end