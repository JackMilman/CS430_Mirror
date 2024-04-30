#!usr/bin/env ruby

module Ast
    class Set
        attr_reader :items

        def initialize(items)
            @items = items
        end

        def size
            @items.size
        end
    end

    class Integer
        attr_reader :value

        def initialize(value)
            @value = value
        end
    end

    class UnaryOperator
        attr_reader :operand

        def initialize(operand)
            @operand = operand
        end
    end

    class Print < UnaryOperator
        def traverse(visitor)
            visitor.visit_print(self)
        end
    end

    class Size < UnaryOperator
    end

    class Serializer
        def visit_print(node)
            # ...
        end
    end
end