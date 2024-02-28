#!usr/bin/env ruby
require_relative './../ast.rb'

module CellTests
    class Test
        def run_tests_serial(visitor, runtime)
            cell_l_value_tests(visitor, runtime)
            cell_r_value_tests(visitor, runtime)
            max_tests(visitor, runtime)
            min_tests(visitor, runtime)
            mean_tests(visitor, runtime)
        end

        def run_tests_eval(eval, ser, runtime)
            set_up_grid(runtime)
            cell_l_value_tests_eval(eval, ser, runtime)
            cell_r_value_tests_eval(eval, ser, runtime)
            max_tests_eval(eval, ser, runtime)
            min_tests_eval(eval, ser, runtime)
            mean_tests_eval(eval, ser, runtime)
            sum_tests_eval(eval, ser, runtime)
        end

        def cell_l_value_tests(visitor, runtime)
            var1 = Ast::CellLValue.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )
            var2 = Ast::CellLValue.new(
                Ast::IntP.new(1),
                Ast::Add.new(
                    Ast::IntP.new(1), 
                    Ast::IntP.new(2)
                )
            )

            result1 = var1.traverse(visitor, runtime)
            puts "Cell Lvalue 1: #{result1}"
            result2 = var2.traverse(visitor, runtime)
            puts "Cell Lvalue 2: #{result2}"
        end

        def cell_r_value_tests(visitor, runtime)
            var1 = Ast::CellRValue.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )
            var2 = Ast::CellRValue.new(
                Ast::IntP.new(1),
                Ast::Add.new(
                    Ast::IntP.new(1), 
                    Ast::IntP.new(2)
                )
            )
            result1 = var1.traverse(visitor, runtime)
            puts "Cell Rvalue 1: #{result1}"
            result2 = var2.traverse(visitor, runtime)
            puts "Cell Rvalue 2: #{result2}"
        end

        def max_tests(visitor, runtime)
            var1 = Ast::CellLValue.new(
                Ast::IntP.new(1),
                Ast::IntP.new(1),
            )
            var2 = Ast::CellLValue.new(
                Ast::IntP.new(1),
                Ast::Add.new(
                    Ast::IntP.new(1), 
                    Ast::IntP.new(2)
                )
            )
            max1 = Ast::Max.new(var1, var2)
            result1 = max1.traverse(visitor, runtime)
            puts "Max 1: #{result1}"
        end

        def min_tests(visitor, runtime)
            var1 = Ast::CellLValue.new(
                Ast::IntP.new(1),
                Ast::IntP.new(1),
            )
            var2 = Ast::CellLValue.new(
                Ast::IntP.new(1),
                Ast::Add.new(
                    Ast::IntP.new(1), 
                    Ast::IntP.new(2)
                )
            )
            min1 = Ast::Min.new(var1, var2)
            result1 = min1.traverse(visitor, runtime)
            puts "Min 1: #{result1}"
        end

        def mean_tests(visitor, runtime)
            var1 = Ast::CellLValue.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )
            var2 = Ast::CellLValue.new(
                Ast::IntP.new(4),
                Ast::Add.new(
                    Ast::IntP.new(1), 
                    Ast::IntP.new(0)
                )
            )
            mean1 = Ast::Max.new(var1, var2)
            result1 = mean1.traverse(visitor, runtime)
            puts "Mean 1: #{result1}"
        end

        #---------------------------------------------------------------------#
        #---------------------------EVALUATOR TESTS---------------------------#
        #---------------------------------------------------------------------#
        def set_up_grid(runtime)
            cell_0_0 = Ast::CellAddressP.new(0, 0)
            cell_0_1 = Ast::CellAddressP.new(0, 1)
            cell_0_2 = Ast::CellAddressP.new(0, 2)
            cell_1_0 = Ast::CellAddressP.new(1, 0)
            cell_1_1 = Ast::CellAddressP.new(1, 1)
            cell_1_2 = Ast::CellAddressP.new(1, 2)
            cell_2_0 = Ast::CellAddressP.new(2, 0)
            cell_2_1 = Ast::CellAddressP.new(2, 1)
            cell_2_2 = Ast::CellAddressP.new(2, 2)
            zero = Ast::IntP.new(0)
            one = Ast::IntP.new(1)
            two = Ast::FloatP.new(2.5)
            twelve = Ast::IntP.new(12)
            neg_one = Ast::IntP.new(-1)
            neg_two = Ast::IntP.new(-2)
            runtime.set_cell(cell_0_0, zero)
            runtime.set_cell(cell_0_1, twelve)
            runtime.set_cell(cell_0_2, neg_one)
            runtime.set_cell(cell_1_0, one)
            runtime.set_cell(cell_1_1, one)
            runtime.set_cell(cell_1_2, neg_two)
            runtime.set_cell(cell_2_0, zero)
            runtime.set_cell(cell_2_1, two)
            runtime.set_cell(cell_2_2, zero)

            # runtime.dump_state
            # expected structure:
            # |  0  |  12  |  -1  |
            # |  1  |   1  |  -2  |
            # |  0  |   2  |   0  |
        end

        def cell_l_value_tests_eval(eval, ser, runtime)
            var1 = Ast::CellLValue.new(
                Ast::IntP.new(1),
                Ast::Add.new(
                    Ast::IntP.new(1), 
                    Ast::IntP.new(2)
                )
            )
            result1 = var1.traverse(eval, runtime)
            puts "Cell Lvalue 1: #{result1.traverse(ser, runtime)}"
        end

        def cell_r_value_tests_eval(eval, ser, runtime)
            var1 = Ast::CellRValue.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )
            var2 = Ast::CellRValue.new(
                Ast::IntP.new(2),
                Ast::IntP.new(2),
            )
            puts "Cell Rvalue 1 address: #{var1.traverse(ser, runtime)}"
            result1 = var1.traverse(eval, runtime)
            puts "Cell Rvalue #[1, 2]: #{result1.traverse(ser, runtime)}"
            result2 = var2.traverse(eval, runtime)
            puts "Cell Rvalue #[2, 2]: #{result2.traverse(ser, runtime)}"
        end

        def max_tests_eval(eval, ser, runtime)
            cell_0_0 = Ast::CellAddressP.new(0, 0)
            cell_0_1 = Ast::CellAddressP.new(0, 1)
            cell_0_2 = Ast::CellAddressP.new(0, 2)
            cell_1_0 = Ast::CellAddressP.new(1, 0)
            cell_1_1 = Ast::CellAddressP.new(1, 1)
            cell_1_2 = Ast::CellAddressP.new(1, 2)
            cell_2_0 = Ast::CellAddressP.new(2, 0)
            cell_2_1 = Ast::CellAddressP.new(2, 1)
            cell_2_2 = Ast::CellAddressP.new(2, 2)

            max1 = Ast::Max.new(cell_0_0, cell_2_2)
            result1 = max1.traverse(eval, runtime)
            puts "Cell Max [0,0] to [2,2]: #{result1.traverse(ser, runtime)}"
            max2 = Ast::Max.new(cell_1_0, cell_1_2)
            result2 = max2.traverse(eval, runtime)
            puts "Cell Max [1,0] to [1,2]: #{result2.traverse(ser, runtime)}"
        end

        def min_tests_eval(eval, ser, runtime)
            cell_0_0 = Ast::CellAddressP.new(0, 0)
            cell_0_1 = Ast::CellAddressP.new(0, 1)
            cell_0_2 = Ast::CellAddressP.new(0, 2)
            cell_1_0 = Ast::CellAddressP.new(1, 0)
            cell_1_1 = Ast::CellAddressP.new(1, 1)
            cell_1_2 = Ast::CellAddressP.new(1, 2)
            cell_2_0 = Ast::CellAddressP.new(2, 0)
            cell_2_1 = Ast::CellAddressP.new(2, 1)
            cell_2_2 = Ast::CellAddressP.new(2, 2)

            min1 = Ast::Min.new(cell_0_0, cell_2_2)
            result1 = min1.traverse(eval, runtime)
            puts "Cell Min [0,0] to [2,2]: #{result1.traverse(ser, runtime)}"
            min2 = Ast::Min.new(cell_1_0, cell_2_1)
            result2 = min2.traverse(eval, runtime)
            puts "Cell Min [1,0] to [2,1]: #{result2.traverse(ser, runtime)}"
        end

        def mean_tests_eval(eval, ser, runtime)
            cell_0_0 = Ast::CellAddressP.new(0, 0)
            cell_0_1 = Ast::CellAddressP.new(0, 1)
            cell_0_2 = Ast::CellAddressP.new(0, 2)
            cell_1_0 = Ast::CellAddressP.new(1, 0)
            cell_1_1 = Ast::CellAddressP.new(1, 1)
            cell_1_2 = Ast::CellAddressP.new(1, 2)
            cell_2_0 = Ast::CellAddressP.new(2, 0)
            cell_2_1 = Ast::CellAddressP.new(2, 1)
            cell_2_2 = Ast::CellAddressP.new(2, 2)

            mean1 = Ast::Mean.new(cell_0_0, cell_2_2)
            result1 = mean1.traverse(eval, runtime)
            puts "Cell Mean [0,0] to [2,2]: #{result1.traverse(ser, runtime)}"
            mean2 = Ast::Mean.new(cell_1_0, cell_2_1)
            result2 = mean2.traverse(eval, runtime)
            puts "Cell Mean [1,0] to [2,1]: #{result2.traverse(ser, runtime)}"
        end

        def sum_tests_eval(eval, ser, runtime)
            cell_0_0 = Ast::CellAddressP.new(0, 0)
            cell_0_1 = Ast::CellAddressP.new(0, 1)
            cell_0_2 = Ast::CellAddressP.new(0, 2)
            cell_1_0 = Ast::CellAddressP.new(1, 0)
            cell_1_1 = Ast::CellAddressP.new(1, 1)
            cell_1_2 = Ast::CellAddressP.new(1, 2)
            cell_2_0 = Ast::CellAddressP.new(2, 0)
            cell_2_1 = Ast::CellAddressP.new(2, 1)
            cell_2_2 = Ast::CellAddressP.new(2, 2)

            sum1 = Ast::Sum.new(cell_0_0, cell_2_2)
            result1 = sum1.traverse(eval, runtime)
            puts "Cell Sum [0,0] to [2,2]: #{result1.traverse(ser, runtime)}"
            sum2 = Ast::Sum.new(cell_1_0, cell_2_1)
            result2 = sum2.traverse(eval, runtime)
            puts "Cell Sum [1,0] to [2,1]: #{result2.traverse(ser, runtime)}"
        end
    end
end