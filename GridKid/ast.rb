#!usr/bin/env ruby

module Ast
    class Primitive
        attr_reader :value

        def initialize(value)
            @value = value
        end
    end

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

    class Exponentiate < NumberBinary
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

    class BitwiseNot < NumberBinary
        def traverse(visitor, payload)
            visitor.visit_bitwise_not(self, payload)
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
            @operand
        end
    end

    class Negate < NumberUnary
        def traverse(visitor, payload)
            visitor.visit_negate(self, payload)
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
            @operand
        end
    end

    class Not < BooleanUnary
        def traverse(visitor, payload)
            visitor.visit_not(self, payload)
        end
    end

    class StringP < Primitive
        def traverse(visitor, payload)
            visitor.visit_string(self, payload)
        end
    end

    class CellAddressP < Primitive
        def traverse(visitor, payload)
            visitor.visit_cell_address(self, payload)
        end
    end

    class CellLValue
    end

    class CellRValue
    end

    class Max
    end

    class Min
    end

    class Mean
    end

    class Sum
    end

    class Serializer
        def visit_integer(node, payload)
            # checking against default Ruby type
            if !node.value.is_a?(Integer)
                raise TypeError, "Not an integer: #{node.value}"
            end
            return "#{node.value}"
        end
        
        def visit_float(node, payload)
            # duck typing with modulo
            if !node.value.respond_to?(:%)
                raise TypeError, "Not a Float or subtype of Float: #{node.value}"
            end
            return "#{node.value}"
        end
        
        def visit_boolean(node, payload)
            # checking against default Ruby types
            if !(node.value == true || node.value == false)
                raise TypeError, "Not a boolean type: #{node.value}"
            end
            return "#{node.value}"
        end
        
        def visit_string(node, payload)
            # checking against default Ruby type
            if !node.value.is_a?(String)
                raise TypeError, "Not a string: #{node.value}"
            end
            return "#{node.value}"
        end
        
        def visit_cell_address(node, payload)
            # checking against default Ruby type
            if !node.value.is_a?(Integer)
                raise TypeError, "Not a valid address: #{node.value}"
            end
            return "#{node.value}"
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
            return "(#{operation}#{op.traverse(self, payload)})"
        end

        def validate_numeric_binary(node, payload)
            good = false
            left_op = node.left_operand
            good = left_op.is_a?(Number)
            if !good
                raise TypeError, "Incompatible left operand"
            end
            right_op = node.right_operand
            good = right_op.is_a?(Number)
            if !good
                raise TypeError, "Incompatible right operand"
            end
            return good
        end

        def validate_numeric_unary(node, payload)
            good = false
            op = node.operand
            good = op.is_a?(Number)
            if !good
                raise TypeError, "Incompatible operator"
            end
            return good
        end

        def visit_add(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "+", payload)
        end

        def visit_sub(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "-", payload)
        end

        def visit_mult(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "*", payload)
        end

        def visit_div(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "/", payload)
        end

        def visit_modulo(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "%", payload)
        end

        def visit_exp(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "^", payload)
        end

        def visit_bitwise_and(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "&", payload)
        end

        def visit_bitwise_or(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "|", payload)
        end
        
        def visit_bitwise_xor(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "^", payload)
        end

        def visit_bitwise_not(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "~", payload)
        end

        def visit_bitwise_left(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "<<", payload)
        end

        def visit_bitwise_right(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, ">>", payload)
        end

        def visit_negate(node, payload) # TODO: UNFINISHED AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
            validate_numeric_unary(node, payload)
            visit_unary(node, "-", payload)
        end

        # Helper method for logical binary operations
        def validate_logical_binary(node, payload)
            good = false
            left_op = node.left_operand
            good = left_op.is_a?(Boolean)
            if !good
                raise TypeError, "Incompatible left operand"
            end
            right_op = node.right_operand
            good = right_op.is_a?(Boolean)
            if !good
                raise TypeError, "Incompatible right operand"
            end
            return good
        end

        def validate_logical_unary(node, payload)
            good = false
            op = node.operand
            good = op.is_a?(Boolean)
            if !good
                raise TypeError, "Incompatible operator"
            end
            return good
        end

        def visit_and(node, payload)
            validate_logical_binary(node, payload)
            visit_binary(node, "and", payload)
        end

        def visit_or(node, payload)
            validate_logical_binary(node, payload)
            visit_binary(node, "or", payload)
        end

        def visit_not(node, payload) # TODO: UNFINISHED AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
            validate_logical_unary(node, payload)
            visit_unary(node, "not ", payload)
        end

        def visit_equals(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "==", payload)
        end
        
        def visit_not_equals(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "!=", payload)
        end
        
        def visit_less_than(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "!=", payload)
        end
        
        def visit_less_than_equal_to(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "!=", payload)
        end
        
        def visit_greater_than(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "!=", payload)
        end
        
        def visit_greater_than_equal_to(node, payload)
            validate_numeric_binary(node, payload)
            visit_binary(node, "!=", payload)
        end
        
        def visit_float_to_int(node, payload)
            # good = false
            # op = node.operand
            # good = op.is_a?(Number)
            # if !good
            #     raise TypeError, "Incompatible operator"
            # end
            # return "(float(#{right_op.traverse(self, payload)}))"
            validate_numeric_unary(node, payload)
            visit_unary(node, "-", payload)
        end

        def visit_float_to_int(node, payload)
            # good = false
            # op = node.operand
            # good = op.is_a?(Number)
            # if !good
            #     raise TypeError, "Incompatible operator"
            # end
            # return "(int(#{right_op.traverse(self, payload)}))"
            validate_numeric_unary(node, payload)
            visit_unary(node, "-", payload)
        end
    end

    class Evaluator

    end
end