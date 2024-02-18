#!usr/bin/env ruby
require_relative './ast.rb'

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
            equals_test(visitor, runtime)
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
            
        end
    
        def or_tests(visitor, runtime)
           
        end

        def not_tests(visitor, runtime)
           
        end

        def equals_tests(visitor, runtime)
           
        end

        def not_equals_tests(visitor, runtime)
           
        end
        
        def less_than_tests(visitor, runtime)
           
        end
        
        def less_than_equal_tests(visitor, runtime)
           
        end
        
        def greater_than_tests(visitor, runtime)
           
        end
        
        def greater_than_equal_tests(visitor, runtime)
           
        end
        
    end
end