#!usr/bin/env ruby

module Ast
    class Primitive
        attr_reader :value

        def initialize(value)
            @value = value
        end
    end

    class Integer < Primitive
        def traverse(visitor, payload)
            visitor.visit_integer(self, nil)
        end
    end

    class Float < Primitive
        def traverse(visitor, payload)
            visitor.visit_float(self, nil)
        end
    end

    class Boolean < Primitive
        def traverse(visitor, payload)
            visitor.visit_boolean(self, nil)
        end
    end

    class String < Primitive
        def traverse(visitor, payload)
            visitor.visit_string(self, nil)
        end
    end

    class CellAddress < Primitive
        def traverse(visitor, payload)
            visitor.visit_cell_address(self, nil)
        end
    end

    class BinaryOperator
        attr_reader :left_operand
        attr_reader :right_operand
        
        def initialize(left, right)
            @left_operand = left
            @right_operand = right
        end
    end

    class Add < BinaryOperator
        def traverse(visitor, payload)
            visitor.visit_add(self, nil)
        end
    end

    class Subtract
    end

    class Multiply
    end

    class Divide
    end

    class Modulo
    end

    class Exponentiate
    end

    class Negate
    end

    class LogicalAnd
    end

    class LogicalOr
    end

    class LogicalNot
    end

    class CellLValue
    end

    class CellRValue
    end

    class BitwiseAnd
    end
    
    class BitwiseOr
    end

    class BitwiseXor
    end

    class BitwiseNot
    end

    class BitwiseLeftShift
    end

    class BitwiseRightShift
    end

    class Equals
    end

    class NotEquals
    end

    class LessThan
    end

    class LessThanEqualTo
    end

    class GreaterThan
    end

    class GreaterThanEqualTo
    end

    class CastFloatToInt
    end

    class CastIntToFloat
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
            return node
        end
        
        def visit_float(node, payload)
            return node
        end
        
        def visit_boolean(node, payload)
            return node
        end
        
        def visit_string(node, payload)
            return node
        end
        
        def visit_cell_address(node, payload)
            return node
        end
    
        def visit_add(node, payload)
            left_op = node.left_operand.traverse(self, nil)
            if left_op.is_a?(Ast::Integer)
                right_op = node.right_operand.traverse(self, nil)
                if right_op.is_a?(Ast::Integer)
                    sum = left_op.value + right_op.value
                    return Ast::Integer.new(left_op.value + right_op.value)
                else
                    raise "Bad right go home"
                end
            else
                raise "Bad left go home"
            end
        end
    end
end