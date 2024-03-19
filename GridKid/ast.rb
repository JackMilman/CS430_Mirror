#!usr/bin/env ruby

module Ast
    # Used as a wrapper for type checking.
    class Number
    end

    class NumberP < Number
        attr_reader :value

        def initialize(value)
            @value = value
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
        
        def initialize(left, right)
            @left_operand = left
            @right_operand = right
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
        
        def initialize(operand)
            @operand = operand
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

        def initialize(value)
            @value = value
        end

        def traverse(visitor, payload)
            visitor.visit_boolean(self, payload)
        end
    end

    class BooleanBinary < Boolean
        attr_reader :left_operand
        attr_reader :right_operand
        
        def initialize(left, right)
            @left_operand = left
            @right_operand = right
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
        
        def initialize(operand)
            @operand = operand
        end
    end

    class Not < BooleanUnary
        def traverse(visitor, payload)
            visitor.visit_not(self, payload)
        end
    end

    class StringP
        attr_reader :value

        def initialize(value)
            @value = value
        end

        def traverse(visitor, payload)
            visitor.visit_string(self, payload)
        end
    end

    class CellAddressP
        attr_reader :row
        attr_reader :column

        def initialize(row, column)
            @row = row
            @column = column
        end

        def traverse(visitor, payload)
            visitor.visit_cell_address(self, payload)
        end
    end

    # Used as a wrapper for type checking.
    class CellReference
        attr_reader :row
        attr_reader :column

        def initialize(row, column)
            @row = row
            @column = column
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

        def initialize(first, last)
            @first = first
            @last = last
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
            return payload.get_cell(address)
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

        def visit_max(node, payload)
            # All four stats functions perform a similar traversal. Consider
            # factoring out some of the grossness to a helper method.
            addresses = validate_cell_func(node, payload)
            max = payload.get_cell(addresses[0])
            for i in addresses[0].row..addresses[1].row
                for j in addresses[0].column..addresses[1].column
                    addr = CellAddressP.new(i, j)
                    tmp = payload.get_cell(addr)
                    if tmp.is_a?(NumberP) and tmp.value > max.value
                        max = tmp
                    end
                end
            end
            return max
        end

        def visit_min(node, payload)
            addresses = validate_cell_func(node, payload)
            min = payload.get_cell(addresses[0])
            for i in addresses[0].row..addresses[1].row
                for j in addresses[0].column..addresses[1].column
                    addr = CellAddressP.new(i, j)
                    tmp = payload.get_cell(addr)
                    if tmp.is_a?(NumberP) and tmp.value < min.value
                        min = tmp
                    end
                end
            end
            return min
        end

        def visit_mean(node, payload)
            addresses = validate_cell_func(node, payload)
            total = IntP.new(0)
            elements = 0
            is_float = false
            for i in addresses[0].row..addresses[1].row
                for j in addresses[0].column..addresses[1].column
                    addr = CellAddressP.new(i, j)
                    tmp = payload.get_cell(addr)
                    if tmp.is_a?(NumberP)
                        if tmp.is_a?(FloatP)
                            is_float = true
                        end
                        if is_float
                            total = FloatP.new(total.value + tmp.value)
                        else
                            total = IntP.new(total.value + tmp.value)
                        end
                        elements += 1
                    end
                end
            end
            if elements == 0
                raise TypeError, "No valid numbers within range" 
            end
            if is_float
                return FloatP.new(total.value / elements)
            else
                return IntP.new(total.value / elements)
            end
        end

        def visit_sum(node, payload)
            addresses = validate_cell_func(node, payload)
            sum = IntP.new(0)
            is_float = false
            for i in addresses[0].row..addresses[1].row
                for j in addresses[0].column..addresses[1].column
                    addr = CellAddressP.new(i, j)
                    tmp = payload.get_cell(addr)
                    if tmp.is_a?(NumberP)
                        if tmp.is_a?(FloatP)
                            is_float = true
                        end
                        if is_float
                            sum = FloatP.new(sum.value + tmp.value)
                        else
                            sum = IntP.new(sum.value + tmp.value)
                        end
                    end
                end
            end
            return sum
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

        def set_cell(address, a_s_t, payload)
            validate_range(address)
            prim = a_s_t.traverse(Evaluator.new, payload)
            @cell_grid[address.row][address.column] = Cell.new(nil, a_s_t, prim)
        end

        def get_cell(address)
            validate_range(address)
            cell_val = @cell_grid[address.row][address.column]
            if cell_val.most_recent_p == nil
                raise TypeError, "Undefined cell"
            end
            return cell_val.most_recent_p
        end

        def dump_state
            for i in 0...self.size
                for j in 0...self.size
                    val = @cell_grid[i][j]
                    print "|[#{i}, #{j}]: "
                    if val.most_recent_p != nil
                        print "#{val.most_recent_p.value} |"
                    else
                        print val
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

        def initialize(size=10)
            @grid = Grid.new(size)
        end

        def set_cell(address, a_s_t)
            @grid.set_cell(address, a_s_t, self)
        end

        def get_cell(address)
            return @grid.get_cell(address)
        end

        def dump_state
            @grid.dump_state
        end
    end
end
