#!usr/bin/env ruby
require_relative './../ast.rb'

module LogicalTests
    class Test
        def run_tests_serial(visitor, runtime)
            puts "---AND---"
            and_tests(visitor, runtime)
            puts
            puts "---OR---"
            or_tests(visitor, runtime)
            puts
            puts "---NOT---"
            not_tests(visitor, runtime)
            puts
            puts "---EQUALS---"
            equals_tests(visitor, runtime)
            puts
            puts "---NOT EQUALS---"
            not_equals_tests(visitor, runtime)
            puts
            puts "---LESS THAN---"
            less_than_tests(visitor, runtime)
            puts
            puts "---LESS THAN EQUAL TO---"
            less_than_equal_tests(visitor, runtime)
            puts
            puts "---GREATER THAN---"
            greater_than_tests(visitor, runtime)
            puts
            puts "---GREATER THAN EQUAL TO---"
            greater_than_equal_tests(visitor, runtime)
        end

        def and_tests(visitor, runtime)
            var1 = Ast::And.new(
                Ast::BooleanP.new(true),
                Ast::BooleanP.new(true),
            )
            var2 = Ast::And.new(
                Ast::BooleanP.new(true),
                Ast::BooleanP.new(false),
            )
            var3 = Ast::And.new(
                Ast::BooleanP.new(false),
                Ast::BooleanP.new(false),
            )
            super_var = Ast::And.new(
                Ast::And.new(
                    Ast::BooleanP.new(true),
                    Ast::BooleanP.new(true),
                ),
                Ast::And.new(
                    Ast::BooleanP.new(false),
                    Ast::BooleanP.new(true)
                )
            )
            result1 = var1.traverse(visitor, runtime)
            puts "And 1: #{result1}"
            result2 = var2.traverse(visitor, runtime)
            puts "And 2: #{result2}"
            result3 = var3.traverse(visitor, runtime)
            puts "And 3: #{result3}"
            super_result = super_var.traverse(visitor, runtime)
            puts "Super And: #{super_result}"
        end
    
        def or_tests(visitor, runtime)
            var1 = Ast::Or.new(
                Ast::BooleanP.new(true),
                Ast::BooleanP.new(true),
            )
            var2 = Ast::Or.new(
                Ast::BooleanP.new(true),
                Ast::BooleanP.new(false),
            )
            var3 = Ast::Or.new(
                Ast::BooleanP.new(false),
                Ast::BooleanP.new(false),
            )
            super_var = Ast::Or.new(
                Ast::Or.new(
                    Ast::BooleanP.new(false),
                    Ast::BooleanP.new(false),
                ),
                Ast::Or.new(
                    Ast::BooleanP.new(false),
                    Ast::BooleanP.new(true)
                )
            )
            result1 = var1.traverse(visitor, runtime)
            puts "Or 1: #{result1}"
            result2 = var2.traverse(visitor, runtime)
            puts "Or 2: #{result2}"
            result3 = var3.traverse(visitor, runtime)
            puts "Or 3: #{result3}"
            super_result = super_var.traverse(visitor, runtime)
            puts "Super Or: #{super_result}"
        end

        def not_tests(visitor, runtime)
            var1 = Ast::Not.new(Ast::BooleanP.new(false))
            var2 = Ast::Not.new(Ast::BooleanP.new(true))
            super_var = Ast::Not.new(
                Ast::Not.new(Ast::BooleanP.new(false))
            )
            result1 = var1.traverse(visitor, runtime)
            puts "Not 1: #{result1}"
            result2 = var2.traverse(visitor, runtime)
            puts "Not 2: #{result2}"
            super_result = super_var.traverse(visitor, runtime)
            puts "Super Not: #{super_result}"
        end

        def equals_tests(visitor, runtime)
            var1 = Ast::Equals.new(
                Ast::IntP.new(7),
                Ast::IntP.new(7),
            )
            var2 = Ast::Equals.new(
                Ast::IntP.new(7),
                Ast::IntP.new(-7),
            )
            var3 = Ast::Equals.new(
                Ast::IntP.new(0),
                Ast::IntP.new(7),
            )
            super_var = Ast::Equals.new(
                Ast::Add.new(
                    Ast::IntP.new(7),
                    Ast::IntP.new(7),
                ),
                Ast::Add.new(
                    Ast::FloatP.new(7.0),
                    Ast::FloatP.new(7.0)
                )
            )
            result1 = var1.traverse(visitor, runtime)
            puts "Equals 1: #{result1}"
            result2 = var2.traverse(visitor, runtime)
            puts "Equals 2: #{result2}"
            result3 = var3.traverse(visitor, runtime)
            puts "Equals 3: #{result3}"
            super_result = super_var.traverse(visitor, runtime)
            puts "Super Equals: #{super_result}"
        end

        def not_equals_tests(visitor, runtime)
            var1 = Ast::NotEquals.new(
                Ast::IntP.new(7),
                Ast::IntP.new(7),
            )
            var2 = Ast::NotEquals.new(
                Ast::IntP.new(7),
                Ast::IntP.new(-7),
            )
            var3 = Ast::NotEquals.new(
                Ast::IntP.new(0),
                Ast::IntP.new(7),
            )
            super_var = Ast::NotEquals.new(
                Ast::Add.new(
                    Ast::IntP.new(7),
                    Ast::IntP.new(7),
                ),
                Ast::Add.new(
                    Ast::FloatP.new(7.0),
                    Ast::FloatP.new(7.0)
                )
            )
            result1 = var1.traverse(visitor, runtime)
            puts "NotEquals 1: #{result1}"
            result2 = var2.traverse(visitor, runtime)
            puts "NotEquals 2: #{result2}"
            result3 = var3.traverse(visitor, runtime)
            puts "NotEquals 3: #{result3}"
            super_result = super_var.traverse(visitor, runtime)
            puts "Super NotEquals: #{super_result}"
        end
        
        def less_than_tests(visitor, runtime)
            var1 = Ast::LessThan.new(
                Ast::IntP.new(7),
                Ast::IntP.new(7),
            )
            var2 = Ast::LessThan.new(
                Ast::IntP.new(7),
                Ast::IntP.new(-7),
            )
            var3 = Ast::LessThan.new(
                Ast::IntP.new(0),
                Ast::IntP.new(7),
            )
            super_var = Ast::LessThan.new(
                Ast::Add.new(
                    Ast::IntP.new(7),
                    Ast::IntP.new(7),
                ),
                Ast::Add.new(
                    Ast::FloatP.new(7.0),
                    Ast::FloatP.new(7.0)
                )
            )
            result1 = var1.traverse(visitor, runtime)
            puts "LessThan 1: #{result1}"
            result2 = var2.traverse(visitor, runtime)
            puts "LessThan 2: #{result2}"
            result3 = var3.traverse(visitor, runtime)
            puts "LessThan 3: #{result3}"
            super_result = super_var.traverse(visitor, runtime)
            puts "Super LessThan: #{super_result}"
        end
        
        def less_than_equal_tests(visitor, runtime)
            var1 = Ast::LessThanEqualTo.new(
                Ast::IntP.new(7),
                Ast::IntP.new(7),
            )
            var2 = Ast::LessThanEqualTo.new(
                Ast::IntP.new(7),
                Ast::IntP.new(-7),
            )
            var3 = Ast::LessThanEqualTo.new(
                Ast::IntP.new(0),
                Ast::IntP.new(7),
            )
            super_var = Ast::LessThanEqualTo.new(
                Ast::Add.new(
                    Ast::IntP.new(7),
                    Ast::IntP.new(7),
                ),
                Ast::Add.new(
                    Ast::FloatP.new(7.0),
                    Ast::FloatP.new(7.0)
                )
            )
            result1 = var1.traverse(visitor, runtime)
            puts "LessThanEqualTo 1: #{result1}"
            result2 = var2.traverse(visitor, runtime)
            puts "LessThanEqualTo 2: #{result2}"
            result3 = var3.traverse(visitor, runtime)
            puts "LessThanEqualTo 3: #{result3}"
            super_result = super_var.traverse(visitor, runtime)
            puts "Super LessThanEqualTo: #{super_result}"
        end
        
        def greater_than_tests(visitor, runtime)
            var1 = Ast::GreaterThan.new(
                Ast::IntP.new(7),
                Ast::IntP.new(7),
            )
            var2 = Ast::GreaterThan.new(
                Ast::IntP.new(7),
                Ast::IntP.new(-7),
            )
            var3 = Ast::GreaterThan.new(
                Ast::IntP.new(0),
                Ast::IntP.new(7),
            )
            super_var = Ast::GreaterThan.new(
                Ast::Add.new(
                    Ast::IntP.new(7),
                    Ast::IntP.new(7),
                ),
                Ast::Add.new(
                    Ast::FloatP.new(7.0),
                    Ast::FloatP.new(7.0)
                )
            )
            result1 = var1.traverse(visitor, runtime)
            puts "GreaterThan 1: #{result1}"
            result2 = var2.traverse(visitor, runtime)
            puts "GreaterThan 2: #{result2}"
            result3 = var3.traverse(visitor, runtime)
            puts "GreaterThan 3: #{result3}"
            super_result = super_var.traverse(visitor, runtime)
            puts "Super GreaterThan: #{super_result}"
        end
        
        def greater_than_equal_tests(visitor, runtime)
            var1 = Ast::GreaterThanEqualTo.new(
                Ast::IntP.new(7),
                Ast::IntP.new(7),
            )
            var2 = Ast::GreaterThanEqualTo.new(
                Ast::IntP.new(7),
                Ast::IntP.new(-7),
            )
            var3 = Ast::GreaterThanEqualTo.new(
                Ast::IntP.new(0),
                Ast::IntP.new(7),
            )
            super_var = Ast::GreaterThanEqualTo.new(
                Ast::Add.new(
                    Ast::IntP.new(7),
                    Ast::IntP.new(7),
                ),
                Ast::Add.new(
                    Ast::FloatP.new(7.0),
                    Ast::FloatP.new(7.0)
                )
            )
            result1 = var1.traverse(visitor, runtime)
            puts "GreaterThanEqualTo 1: #{result1}"
            result2 = var2.traverse(visitor, runtime)
            puts "GreaterThanEqualTo 2: #{result2}"
            result3 = var3.traverse(visitor, runtime)
            puts "GreaterThanEqualTo 3: #{result3}"
            super_result = super_var.traverse(visitor, runtime)
            puts "Super GreaterThanEqualTo: #{super_result}"
        end
        
    end
end