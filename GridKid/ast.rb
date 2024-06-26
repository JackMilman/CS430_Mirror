#!usr/bin/env ruby

module Ast
    # Used as a wrapper for type checking.
    class Number
    end

    class NumberP < Number
        attr_reader :value
        attr_reader :indices

        def initialize(value, indices = nil)
            @value = value
            @indices = indices
        end
    end

    class IntP < NumberP
        def traverse(visitor, payload)
            visitor.visit_integer(self, payload)
        end
    end

    class FloatP < NumberP
        def traverse(visitor, payload)
            visitor.visit_float(self, payload)
        end
    end

    class NumberBinary < Number
        attr_reader :left_operand
        attr_reader :right_operand
        attr_reader :indices
        
        def initialize(left, right, indices = nil)
            @left_operand = left
            @right_operand = right
            @indices = indices
        end
    end

    class Add < NumberBinary
        def traverse(visitor, payload)
            visitor.visit_add(self, payload)
        end
    end

    class Subtract < NumberBinary
        def traverse(visitor, payload)
            visitor.visit_sub(self, payload)
        end
    end

    class Multiply < NumberBinary
        def traverse(visitor, payload)
            visitor.visit_mult(self, payload)
        end
    end

    class Divide < NumberBinary
        def traverse(visitor, payload)
            visitor.visit_div(self, payload)
        end
    end

    class Modulo < NumberBinary
        def traverse(visitor, payload)
            visitor.visit_modulo(self, payload)
        end
    end

    class Exponent < NumberBinary
        def traverse(visitor, payload)
            visitor.visit_exp(self, payload)
        end
    end

    class BitwiseAnd < NumberBinary
        def traverse(visitor, payload)
            visitor.visit_bitwise_and(self, payload)
        end
    end
    
    class BitwiseOr < NumberBinary
        def traverse(visitor, payload)
            visitor.visit_bitwise_or(self, payload)
        end
    end

    class BitwiseXor < NumberBinary
        def traverse(visitor, payload)
            visitor.visit_bitwise_xor(self, payload)
        end
    end

    class BitwiseLeftShift < NumberBinary
        def traverse(visitor, payload)
            visitor.visit_bitwise_left(self, payload)
        end
    end

    class BitwiseRightShift < NumberBinary
        def traverse(visitor, payload)
            visitor.visit_bitwise_right(self, payload)
        end
    end

    class NumberUnary < Number
        attr_reader :operand
        attr_reader :indices
        
        def initialize(operand, indices = nil)
            @operand = operand
            @indices = indices
        end
    end

    class Negate < NumberUnary
        def traverse(visitor, payload)
            visitor.visit_negate(self, payload)
        end
    end

    class BitwiseNot < NumberUnary
        def traverse(visitor, payload)
            visitor.visit_bitwise_not(self, payload)
        end
    end

    class CastFloatToInt < NumberUnary
        def traverse(visitor, payload)
            visitor.visit_float_to_int(self, payload)
        end
    end

    class CastIntToFloat < NumberUnary
        def traverse(visitor, payload)
            visitor.visit_int_to_float(self, payload)
        end
    end

    # Used as a wrapper for type checking.

    class Boolean
    end

    class BooleanP < Boolean
        attr_reader :value
        attr_reader :indices

        def initialize(value, indices = nil)
            @value = value
            @indices = indices
        end

        def traverse(visitor, payload)
            visitor.visit_boolean(self, payload)
        end
    end

    class BooleanBinary < Boolean
        attr_reader :left_operand
        attr_reader :right_operand
        attr_reader :indices
        
        def initialize(left, right, indices = nil)
            @left_operand = left
            @right_operand = right
            @indices = indices
        end
    end

    class And < BooleanBinary
        def traverse(visitor, payload)
            visitor.visit_and(self, payload)
        end
    end

    class Or < BooleanBinary
        def traverse(visitor, payload)
            visitor.visit_or(self, payload)
        end
    end

    class Equals < BooleanBinary
        def traverse(visitor, payload)
            visitor.visit_equals(self, payload)
        end
    end

    class NotEquals < BooleanBinary
        def traverse(visitor, payload)
            visitor.visit_not_equals(self, payload)
        end
    end

    class LessThan < BooleanBinary
        def traverse(visitor, payload)
            visitor.visit_less_than(self, payload)
        end
    end

    class LessThanEqualTo < BooleanBinary
        def traverse(visitor, payload)
            visitor.visit_less_than_equal_to(self, payload)
        end
    end

    class GreaterThan < BooleanBinary
        def traverse(visitor, payload)
            visitor.visit_greater_than(self, payload)
        end
    end

    class GreaterThanEqualTo < BooleanBinary
        def traverse(visitor, payload)
            visitor.visit_greater_than_equal_to(self, payload)
        end
    end

    class BooleanUnary < Boolean
        attr_reader :operand
        attr_reader :indices
        
        def initialize(operand, indices = nil)
            @operand = operand
            @indices = indices
        end
    end

    class Not < BooleanUnary
        def traverse(visitor, payload)
            visitor.visit_not(self, payload)
        end
    end

    class StringP
        attr_reader :value
        attr_reader :indices

        def initialize(value, indices = nil)
            @value = value
            @indices = indices
        end

        def traverse(visitor, payload)
            visitor.visit_string(self, payload)
        end
    end

    class CellAddressP
        attr_reader :row
        attr_reader :column
        attr_reader :indices

        def initialize(row, column, indices = nil)
            @row = row
            @column = column
            @indices = indices
        end

        def traverse(visitor, payload)
            visitor.visit_cell_address(self, payload)
        end
    end

    # Used as a wrapper for type checking.
    class CellReference
        attr_reader :row
        attr_reader :column
        attr_reader :indices

        def initialize(row, column, indices = nil)
            @row = row
            @column = column
            @indices = indices
        end
    end

    class CellLValue < CellReference
        def traverse(visitor, payload)
            visitor.visit_cell_l_value(self, payload)
        end
    end

    class CellRValue < CellReference
        def traverse(visitor, payload)
            visitor.visit_cell_r_value(self, payload)
        end
    end

    # Used as a wrapper for type checking.
    class CellFunction
        attr_reader :first
        attr_reader :last
        attr_reader :indices

        def initialize(first, last, indices = nil)
            @first = first
            @last = last
            @indices = indices
        end
    end

    class Max < CellFunction
        def traverse(visitor, payload)
            visitor.visit_max(self, payload)
        end
    end

    class Min < CellFunction
        def traverse(visitor, payload)
            visitor.visit_min(self, payload)
        end
    end

    class Mean < CellFunction
        def traverse(visitor, payload)
            visitor.visit_mean(self, payload)
        end
    end

    class Sum < CellFunction
        def traverse(visitor, payload)
            visitor.visit_sum(self, payload)
        end
    end

    class Block
        attr_reader :statements
        attr_reader :indices

        def initialize(statements, indices=nil)
            @statements = statements
            @indices = indices
        end

        def traverse(visitor, payload)
            visitor.visit_block(self, payload)
        end
    end

    class Assignment
        attr_reader :var_ident
        attr_reader :expression
        attr_reader :indices

        def initialize(var_ident, expression, indices=nil)
            @var_ident = var_ident
            @expression = expression
            @indices = indices
        end

        def traverse(visitor, payload)
            visitor.visit_assignment(self, payload)
        end
    end

    class VariableRef
        attr_reader :var_ident
        attr_reader :indices

        def initialize(var_ident, indices=nil)
            @var_ident = var_ident
            @indices = indices
        end

        def traverse(visitor, payload)
            visitor.visit_variable_ref(self, payload)
        end
    end

    class Conditional
        attr_reader :predicate
        attr_reader :then_block
        attr_reader :else_block
        attr_reader :indices

        def initialize(predicate, then_block, else_block, indices=nil)
            @predicate = predicate
            @then_block = then_block
            @else_block = else_block
            @indices = indices
        end

        def traverse(visitor, payload)
            visitor.visit_conditional(self, payload)
        end
    end

    class ForEach
        attr_reader :iterator
        attr_reader :first
        attr_reader :last
        attr_reader :inclusive
        attr_reader :block
        attr_reader :indices

        def initialize(iterator, first, last, inclusive, block, indices=nil)
            @iterator = iterator
            @first = first
            @last = last
            @inclusive = inclusive
            @block = block
            @indices = indices
        end

        def traverse(visitor, payload)
            visitor.visit_for_each(self, payload)
        end
    end

    #-------------------------------------------------------------------------#
    #--------------------------------Serializer-------------------------------#
    #-------------------------------------------------------------------------#
    class Serializer
        def visit_integer(node, payload)
            return node.value.to_s
        end
        
        def visit_float(node, payload)
            return node.value.to_s
        end
        
        def visit_boolean(node, payload)
            return node.value.to_s
        end
        
        def visit_string(node, payload)
            return node.value.to_s
        end
        
        def visit_cell_address(node, payload)
            return "[#{node.row}, #{node.column}]"
        end

        # Helper method for binary operations
        def visit_binary(node, operation, payload)
            left_op = node.left_operand
            right_op = node.right_operand
            return "(#{left_op.traverse(self, payload)} #{operation} #{right_op.traverse(self, payload)})"
        end

        # Helper method for unary operations
        def visit_unary(node, operation, payload)
            op = node.operand
            return "#{operation}(#{op.traverse(self, payload)})"
        end
        
        #----------------------------------#
        #   !!! ARITHMETIC VISITORS !!!    #
        #----------------------------------#
        def visit_add(node, payload)
            visit_binary(node, "+", payload)
        end

        def visit_sub(node, payload)
            visit_binary(node, "-", payload)
        end

        def visit_mult(node, payload)
            visit_binary(node, "*", payload)
        end

        def visit_div(node, payload)
            visit_binary(node, "/", payload)
        end

        def visit_modulo(node, payload)
            visit_binary(node, "%", payload)
        end

        def visit_exp(node, payload)
            visit_binary(node, "**", payload)
        end

        def visit_negate(node, payload)
            visit_unary(node, "-", payload)
        end

        #----------------------------------#
        #   !!! BITWISE VISITORS !!!       #
        #----------------------------------#
        def visit_bitwise_and(node, payload)
            visit_binary(node, "&", payload)
        end

        def visit_bitwise_or(node, payload)
            visit_binary(node, "|", payload)
        end
        
        def visit_bitwise_xor(node, payload)
            visit_binary(node, "^", payload)
        end

        def visit_bitwise_not(node, payload)
            visit_unary(node, "~", payload)
        end

        def visit_bitwise_left(node, payload)
            visit_binary(node, "<<", payload)
        end

        def visit_bitwise_right(node, payload)
            visit_binary(node, ">>", payload)
        end

        #----------------------------------#
        #   !!! LOGICAL VISITORS !!!       #
        #----------------------------------#

        def visit_and(node, payload)
            visit_binary(node, "&&", payload)
        end

        def visit_or(node, payload)
            visit_binary(node, "||", payload)
        end

        def visit_not(node, payload)
            visit_unary(node, "!", payload)
        end

        def visit_equals(node, payload)
            visit_binary(node, "==", payload)
        end
        
        def visit_not_equals(node, payload)
            visit_binary(node, "!=", payload)
        end
        
        def visit_less_than(node, payload)
            visit_binary(node, "<", payload)
        end
        
        def visit_less_than_equal_to(node, payload)
            visit_binary(node, "<=", payload)
        end
        
        def visit_greater_than(node, payload)
            visit_binary(node, ">", payload)
        end
        
        def visit_greater_than_equal_to(node, payload)
            visit_binary(node, ">=", payload)
        end

        #----------------------------------#
        #   !!! CASTING VISITORS !!!       #
        #----------------------------------#
        def visit_float_to_int(node, payload)
            visit_unary(node, "int", payload)
        end

        def visit_int_to_float(node, payload)
            visit_unary(node, "float", payload)
        end

        #----------------------------------#
        #   !!! CELL REF VISITORS !!!      #
        #----------------------------------#
        def visit_cell_l_value(node, payload)
            return "[#{node.row.traverse(self, payload)}, #{node.column.traverse(self, payload)}]"
        end

        def visit_cell_r_value(node, payload)
            return "#[#{node.row.traverse(self, payload)}, #{node.column.traverse(self, payload)}]"
        end

        #----------------------------------#
        #   !!! CELL FUNC VISITORS !!!     #
        #----------------------------------#
        def visit_cell_func(node, operation, payload)
            first = node.first
            last = node.last
            return "#{operation}(#{first.traverse(self, payload)}, #{last.traverse(self, payload)})"
        end

        def visit_max(node, payload)
            visit_cell_func(node, "max", payload)
        end

        def visit_min(node, payload)
            visit_cell_func(node, "min", payload)
        end

        def visit_mean(node, payload)
            visit_cell_func(node, "mean", payload)
        end

        def visit_sum(node, payload)
            visit_cell_func(node, "sum", payload)
        end

        #----------------------------------#
        #     !!! VARIABLE VISITORS !!!    #
        #----------------------------------#
        def visit_block(node, payload)
            block = node.statements.collect{|statement| statement.traverse(self, payload)}.join("\n")
            return "{\n#{block.split("\n").map{|line| "  " ++ line}.join("\n")}\n}"
        end

        def visit_assignment(node, payload)
            return "#{node.var_ident} = #{node.expression.traverse(self, payload)}"
        end
        
        def visit_variable_ref(node, payload)
            return "#{node.var_ident}"
        end

        def visit_conditional(node, payload)
            pred = "if #{node.predicate.traverse(self, payload)}\n"
            then_b = "#{node.then_block.traverse(self, payload).split("\n").map{|line| "  " ++ line }.join("\n")}\n"
            else_b = "#{node.else_block.traverse(self, payload).split("\n").map{|line| "  " ++ line }.join("\n")}\n"
            return pred ++ then_b ++ "else\n" ++ else_b ++ "end"
        end

        def visit_for_each(node, payload)
            iteration = "for #{node.iterator.traverse(self, payload)} in "
            lower = "#{node.first.traverse(self, payload)}"
            upper = "#{node.last.traverse(self, payload)}"
            inc = node.inclusive ? ".." : "..."
            range = lower ++ inc ++ upper ++ "\n"
            first_line = iteration ++ range
            block = "#{node.block.traverse(self, payload).split("\n").map{|line| "  " ++ line }.join("\n")}\n"
            return first_line ++ block ++ "end"
        end
    end
    #-------------------------------------------------------------------------#
    #--------------------------------Evaluator--------------------------------#
    #-------------------------------------------------------------------------#
    class Evaluator
        def visit_integer(node, payload)
            # checking against default Ruby type
            if !node.value.is_a?(Integer)
                raise TypeError, "Not an integer: #{node.value}"
            end
            return node
        end
        
        def visit_float(node, payload)
            # duck typing with modulo
            if !node.value.respond_to?(:/)
                raise TypeError, "Not a Float or subtype of Float: #{node.value}"
            end
            return node
        end
        
        def visit_boolean(node, payload)
            # checking against default Ruby types
            if !(node.value == true || node.value == false)
                raise TypeError, "Not a boolean type: #{node.value}"
            end
            return node
        end
        
        def visit_string(node, payload)
            # checking against default Ruby type
            if !node.value.is_a?(String)
                raise TypeError, "Not a string: #{node.value}"
            end
            return node
        end
        
        def visit_cell_address(node, payload)
            # checking against default Ruby type
            if !node.row.is_a?(Integer)
                raise TypeError, "Invalid row: #{node.row}"
            end
            if !node.column.is_a?(Integer)
                raise TypeError, "Invalid column: #{node.column}"
            end
            return node
        end

        #----------------------------------#
        #  ____ NUMERIC VALIDATORS ____    #
        #----------------------------------#
        def validate_numeric_binary(node, payload)
            left = node.left_operand.traverse(self, payload)
            if !left.is_a?(NumberP)
                raise TypeError, "Left operand not a number"
            end
            right = node.right_operand.traverse(self, payload)
            if !right.is_a?(NumberP)
                raise TypeError, "Right operand is not a number"
            end
            is_float = left.is_a?(FloatP) || right.is_a?(FloatP)
            return left.value, right.value, is_float
        end

        def validate_numeric_unary(node, payload)
            op = node.operand.traverse(self, payload)
            if !op.is_a?(NumberP)
                raise TypeError, "Operand is not a number"
            end
            is_float = op.is_a?(FloatP)
            return op.value, is_float
        end

        def validate_bitwise_binary(node, payload)
            left = node.left_operand.traverse(self, payload)
            if !left.is_a?(IntP)
                raise TypeError, "Left operand not an integer"
            end
            right = node.right_operand.traverse(self, payload)
            if !right.is_a?(IntP)
                raise TypeError, "Right operand is not an integer"
            end
            return left.value, right.value
        end

        def validate_bitwise_unary(node, payload)
            op = node.operand.traverse(self, payload)
            if !op.is_a?(IntP)
                raise TypeError, "Operand is not a number"
            end
            return op.value
        end

        #----------------------------------#
        #  ____ LOGICAL VALIDATORS ____    #
        #----------------------------------#
        def validate_logical_binary(node, payload)
            left = node.left_operand.traverse(self, payload)
            if !left.is_a?(BooleanP)
                raise TypeError, "Left operand not a number"
            end
            right = node.right_operand.traverse(self, payload)
            if !right.is_a?(BooleanP)
                raise TypeError, "Right operand is not a number"
            end
            return left.value, right.value
        end

        def validate_logical_unary(node, payload)
            op = node.operand.traverse(self, payload)
            if !op.is_a?(BooleanP)
                raise TypeError, "Operand is not a number"
            end
            return op.value
        end

        #----------------------------------#
        #   !!! ARITHMETIC VISITORS !!!    #
        #----------------------------------#
        def visit_add(node, payload)
            results = validate_numeric_binary(node, payload)
            if results[2] # is_float
                return FloatP.new(results[0] + results[1])
            else
                return IntP.new(results[0] + results[1])
            end
        end

        def visit_sub(node, payload)
            results = validate_numeric_binary(node, payload)
            if results[2] # is_float
                return FloatP.new(results[0] - results[1])
            else
                return IntP.new(results[0] - results[1])
            end
        end

        def visit_mult(node, payload)
            results = validate_numeric_binary(node, payload)
            if results[2] # is_float
                return FloatP.new(results[0] * results[1])
            else
                return IntP.new(results[0] * results[1])
            end
        end

        def visit_div(node, payload)
            results = validate_numeric_binary(node, payload)
            if results[2] # is_float
                return FloatP.new(results[0] / results[1])
            else
                return IntP.new(results[0] / results[1])
            end
        end
        
        def visit_modulo(node, payload)
            results = validate_numeric_binary(node, payload)
            if results[2] # is_float
                return FloatP.new(results[0] % results[1])
            else
                return IntP.new(results[0] % results[1])
            end
        end

        def visit_exp(node, payload)
            results = validate_numeric_binary(node, payload)
            if results[2] # is_float
                return FloatP.new(results[0] ** results[1])
            else
                return IntP.new(results[0] ** results[1])
            end
        end

        def visit_negate(node, payload)
            results = validate_numeric_unary(node, payload)
            if results[1] # is_float
                return FloatP.new(-results[0])
            else
                return IntP.new(-results[0])
            end
        end

        #----------------------------------#
        #   !!! BITWISE VISITORS !!!       #
        #----------------------------------#
        def visit_bitwise_and(node, payload)
            results = validate_bitwise_binary(node, payload)
            return IntP.new(results[0] & results[1])
        end

        def visit_bitwise_or(node, payload)
            results = validate_bitwise_binary(node, payload)
            return IntP.new(results[0] | results[1])
        end
        
        def visit_bitwise_xor(node, payload)
            results = validate_bitwise_binary(node, payload)
            return IntP.new(results[0] ^ results[1])
        end

        def visit_bitwise_not(node, payload)
            results = validate_bitwise_unary(node, payload)
            return IntP.new(~results[0])
        end

        def visit_bitwise_left(node, payload)
            results = validate_bitwise_binary(node, payload)
            return IntP.new(results[0] << results[1])
        end

        def visit_bitwise_right(node, payload)
            results = validate_bitwise_binary(node, payload)
            return IntP.new(results[0] >> results[1])
        end

        #----------------------------------#
        #   !!! LOGICAL VISITORS !!!       #
        #----------------------------------#

        def visit_and(node, payload)
            results = validate_logical_binary(node, payload)
            return BooleanP.new(results[0] && results[1])
        end

        def visit_or(node, payload)
            results = validate_logical_binary(node, payload)
            return BooleanP.new(results[0] || results[1])
        end

        def visit_not(node, payload)
            results = validate_logical_unary(node, payload)
            return BooleanP.new(!results)
        end

        def visit_equals(node, payload)
            results = validate_numeric_binary(node, payload)
            return BooleanP.new(results[0] == results[1])
        end
        
        def visit_not_equals(node, payload)
            results = validate_numeric_binary(node, payload)
            return BooleanP.new(results[0] != results[1])
        end
        
        def visit_less_than(node, payload)
            results = validate_numeric_binary(node, payload)
            return BooleanP.new(results[0] < results[1])
        end
        
        def visit_less_than_equal_to(node, payload)
            results = validate_numeric_binary(node, payload)
            return BooleanP.new(results[0] <= results[1])
        end
        
        def visit_greater_than(node, payload)
            results = validate_numeric_binary(node, payload)
            return BooleanP.new(results[0] > results[1])
        end
        
        def visit_greater_than_equal_to(node, payload)
            results = validate_numeric_binary(node, payload)
            return BooleanP.new(results[0] >= results[1])
        end

        #----------------------------------#
        #   !!! CASTING VISITORS !!!       #
        #----------------------------------#
        def visit_float_to_int(node, payload)
            results = validate_numeric_unary(node, payload)
            return IntP.new(results[0].to_i)
        end

        def visit_int_to_float(node, payload)
            results = validate_numeric_unary(node, payload)
            return FloatP.new(results[0].to_f)
        end

        #----------------------------------#
        #   !!! CELL REF VISITORS !!!      #
        #----------------------------------#
        def validate_cell(node, payload)
            row = node.row.traverse(self, payload)
            if !row.is_a?(IntP)
                raise TypeError, "Invalid row: #{node.row}"
            end
            col = node.column.traverse(self, payload)
            if !col.is_a?(IntP)
                raise TypeError, "Invalid column: #{node.column}"
            end
            return row, col
        end

        def visit_cell_l_value(node, payload)
            results = validate_cell(node, payload)
            return CellAddressP.new(results[0].value, results[1].value)
        end

        def visit_cell_r_value(node, payload)
            results = validate_cell(node, payload)
            address = CellAddressP.new(results[0].value, results[1].value)
            
            return payload.get_cell(address).most_recent_p
        end

        #----------------------------------#
        #   !!! CELL FUNC VISITORS !!!     #
        #----------------------------------#
        def validate_cell_func(node, payload)
            first = node.first.traverse(self, payload)
            if !first.is_a?(CellAddressP)
                raise TypeError, "Invalid start address: Not an address"
            end
            last = node.last.traverse(self, payload)
            if !last.is_a?(CellAddressP)
                raise TypeError, "Invalid end address: Not an address"
            end
            if last.row < first.row || last.column < first.column
                raise IndexError, "Invalid selection: Improper bounds"
            end
            return first, last
        end

        def statistical_traverse(node, payload, type)
            addresses = validate_cell_func(node, payload)
            result = (type == :max || type == :min) ? payload.get_cell(addresses[0]).most_recent_p : 0
            elements = 0
            is_float = false

            for i in addresses[0].row..addresses[1].row
                for j in addresses[0].column..addresses[1].column
                    addr = CellAddressP.new(i, j)
                    tmp = payload.get_cell(addr).most_recent_p
                    if tmp.is_a?(NumberP)
                        if type == :max
                            result = (tmp.value > result.value) ? tmp : result
                        elsif type == :min
                            result = (tmp.value < result.value) ? tmp : result
                        else # mean and sum both accumulate their results
                            if tmp.is_a?(FloatP)
                                is_float = true
                            end
                            result = result + tmp.value
                        end
                        elements += 1
                    end
                end
            end
            
            if type == :mean
                if elements == 0
                    raise TypeError, "No valid numbers within range" 
                end
                result = is_float ? FloatP.new(result / elements) : IntP.new(result / elements)
            elsif type == :sum
                result = is_float ? FloatP.new(result) : IntP.new(result)
            end
            return result
        end

        def visit_max(node, payload)
            return statistical_traverse(node, payload, :max)
        end

        def visit_min(node, payload)
            return statistical_traverse(node, payload, :min)
        end

        def visit_mean(node, payload)
            return statistical_traverse(node, payload, :mean)
        end

        def visit_sum(node, payload)
            return statistical_traverse(node, payload, :sum)
        end

        #----------------------------------#
        #    !!! VARIABLE VISITORS !!!     #
        #----------------------------------#
        def visit_block(node, payload)
            result = nil
            if node.statements.length < 1
                raise TypeError, "Block cannot be resolved to a value because there are no statements inside."
            end
            node.statements.each do |statement|
              result = statement.traverse(self, payload)
            end
            return result
        end

        def visit_assignment(node, payload)
            prim_val = node.expression.traverse(self, payload)
            good = prim_val.is_a?(NumberP) || prim_val.is_a?(BooleanP) || prim_val.is_a?(StringP) || prim_val.is_a?(CellAddressP)
            if !good
                raise TypeError, "Unable to evaluate expression"
            else
                payload.assign_var(node.var_ident, prim_val)
                payload.get_var(node.var_ident)
            end
        end

        def visit_variable_ref(node, payload)
            prim_val = payload.get_var(node.var_ident)
            if prim_val == nil
                raise TypeError, "#{node.var_ident} is an uninitialized value"
            else 
                return prim_val
            end
        end

        def visit_conditional(node, payload)
            pred = node.predicate.traverse(self, payload)
            if !pred.is_a?(Boolean)
                raise TypeError, "Predicate cannot be resolved to a boolean"
            end
            if pred.value
                return node.then_block.traverse(self, payload)
            else
                return node.else_block.traverse(self, payload)
            end
        end

        def visit_for_each(node, payload)
            addresses = validate_cell_func(node, payload)
            iterator = node.iterator
            result = StringP.new("Error")
            row_range = node.inclusive ? (addresses[0].row..addresses[1].row) : (addresses[0].row...addresses[1].row)
            col_range = node.inclusive ? (addresses[0].column..addresses[1].column) : (addresses[0].column...addresses[1].column)

            (row_range).each do |row|
              (col_range).each do |col|
                addr = CellAddressP.new(row, col)
                ast = payload.get_cell(addr).a_s_t
                if ast != nil
                    cell_result = payload.get_cell(addr).a_s_t.traverse(self, Runtime.new(payload.grid))
                    payload.assign_var(iterator.var_ident, cell_result)
                    result = node.block.traverse(self, payload)
                end
              end
            end
            return result
        end
    end

    #-------------------------------------------------------------------------#
    #----------------------------------Grid-----------------------------------#
    #-------------------------------------------------------------------------#
    class Grid
        attr_accessor :cell_grid
        attr_accessor :size

        def initialize(size=10)
            @cell_grid = Array.new(size) {Array.new(size, Cell.new(nil, nil, nil))}
            @size = size
        end

        class Cell
            attr_accessor :code
            attr_accessor :a_s_t
            attr_accessor :most_recent_p

            def initialize(code, a_s_t, most_recent_p)
                @code = code
                @a_s_t = a_s_t
                @most_recent_p = most_recent_p
            end
        end

        def validate_range(address)
            if !address.is_a?(CellAddressP)
                raise TypeError, "Not an address"
            end
            if address.row < 0 || address.row >= size
                raise IndexError, "Out of bounds: row"
            end
            if address.column < 0 || address.column >= size
                raise IndexError, "Out of bounds: column"
            end
        end

        def set_cell(source, address, a_s_t, payload)
            validate_range(address)
            prim = a_s_t == nil ? nil : a_s_t.traverse(Evaluator.new, payload)
            @cell_grid[address.row][address.column] = Cell.new(source, a_s_t, prim)
        end

        def get_cell(address)
            validate_range(address)
            cell_val = @cell_grid[address.row][address.column]
            return cell_val
        end

        def dump_state
            for i in 0...self.size
                for j in 0...self.size
                    val = @cell_grid[i][j]
                    print "|[#{i}, #{j}]: "
                    if val.most_recent_p != nil
                        print "#{val.most_recent_p.value} |"
                    else
                        print "___ | "
                    end
                end
                puts
            end
        end
    end

    #-------------------------------------------------------------------------#
    #---------------------------------Runtime---------------------------------#
    #-------------------------------------------------------------------------#
    class Runtime
        attr_accessor :grid

        def initialize(grid)
            @grid = grid
            @var_dictionary = {}
        end

        def set_cell(source="", address, a_s_t)
            @grid.set_cell(source, address, a_s_t, self)
        end

        def get_cell(address)
            return @grid.get_cell(address)
        end

        def assign_var(var_ident, primitive)
            @var_dictionary[var_ident] = primitive
        end

        def get_var(var_ident)
            return @var_dictionary[var_ident]
        end

        def dump_state
            @grid.dump_state
        end
    end    
end
