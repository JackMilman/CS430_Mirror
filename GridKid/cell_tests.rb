require_relative './ast.rb'

module CellTests
    class Test
        def run_tests_serial(visitor, runtime)
            cell_l_value_tests(visitor, runtime)
            cell_r_value_tests(visitor, runtime)
        end

        def run_tests_eval(eval, ser, runtime)
            cell_l_value_tests_eval(eval, ser, runtime)
            cell_r_value_tests_eval(eval, ser, runtime)
        end

        def cell_l_value_tests(visitor, runtime)
            var1 = Ast::CellLValue.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )

            result1 = var1.traverse(visitor, runtime)
            puts "Cell Lvalue 1: #{result1}"
        end

        def cell_l_value_tests_eval(eval, ser, runtime)
            
        end

        def cell_r_value_tests(visitor, runtime)
            var1 = Ast::CellRValue.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )

            result1 = var1.traverse(visitor, runtime)
            puts "Cell Rvalue 1: #{result1}"
        end

        def cell_r_value_tests_eval(eval, ser, runtime)
            add_operation = Ast::Add.new(
                Ast::IntP.new(1), 
                Ast::IntP.new(2)
                )
            runtime.set_cell(Ast::CellAddressP.new(1, 2), add_operation)

            var1 = Ast::CellRValue.new(
                Ast::IntP.new(1),
                Ast::IntP.new(2),
            )

            result1 = var1.traverse(eval, runtime)
            puts "Cell Lvalue 1: #{result1.traverse(ser, runtime)}"
        end
    end
end