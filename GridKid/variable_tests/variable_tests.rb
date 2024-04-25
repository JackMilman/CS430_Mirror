#!usr/bin/env ruby
require_relative '../ast.rb'
require_relative '../interp.rb'

include Ast
include Interp

block1 = Block.new([
    Assignment.new(
        "var",
        Add.new(
            IntP.new(5),
            IntP.new(7)
        )
    ),
    Assignment.new(
        "abcd",
        Multiply.new(
            IntP.new(2),
            IntP.new(3)
        )
    ),
    Add.new(
        VariableRef.new(
            "var"
        ),
        VariableRef.new(
            "abcd"
        )
    ),
])

example = Block.new([
    Assignment.new(
        "proportion",
        Add.new(
            CellRValue.new(IntP.new(0), IntP.new(0)),
            IntP.new(1)
        )
    ),
    Assignment.new(
        "amount",
        IntP.new(7)
    ),
    Multiply.new(
        VariableRef.new("proportion"),
        VariableRef.new("amount")
    )
])

ass1 = Assignment.new(
    "var",
    Add.new(
        IntP.new(5),
        IntP.new(7)
    )
)

# (block1.statements).each{|statement| puts statement.inspect}

grid = Grid.new(3)
run = Runtime.new(grid)
run.set_cell(CellAddressP.new(0,0), IntP.new(5))
ser = Serializer.new
eva = Evaluator.new
# puts "#{block1.traverse(ser, run)}"
# puts "#{block1.traverse(eva, run).inspect}" # expect 18
# grid.dump_state
# puts "#{example.traverse(ser, run)}"
# puts "#{example.traverse(eva, run).inspect}" # expect 42

# puts
# source = "{var = 12\nabcd = #[0,0]\nvar + abcd}"
# tester = Lexer.new(source) # Expect 17
# toks = tester.lex
# puts
# puts "SOURCE:"
# toks.each{|tok| print tok.source + " "}
# parser = Parser.new(toks)
# block_test = parser.parse

# Runtime.new(grid).set_cell(source, CellAddressP.new(1, 0), block_test)
# cell = Runtime.new(grid).get_cell(CellAddressP.new(1,0))
# puts
# puts "GRID SOURCE:"
# puts cell.code
# puts
# puts "SERIALIZED:"
# puts "#{block_test.traverse(ser, Runtime.new(grid))}"
# puts "EVALUATED:"
# puts "#{block_test.traverse(eva, Runtime.new(grid)).inspect}"


if_test = Conditional.new(
    Equals.new(
        IntP.new(5),
        IntP.new(5)
    ),
    IntP.new(1),
    IntP.new(2)
)
puts "SERIALIZED:"
puts "#{if_test.traverse(ser, Runtime.new(grid))}"
puts "EVALUATED:"
puts "#{if_test.traverse(eva, Runtime.new(grid)).inspect}"

source = "if #[2, 1] < #[2,0]\n1\nelse\n2\nend"
tester = Lexer.new(source)
toks = tester.lex
puts
puts "SOURCE:"
toks.each{|tok| print tok.source}
parser = Parser.new(toks)
if_test = parser.parse

puts
grid = Grid.new(3)
run = Runtime.new(grid)
run.set_cell("2", CellAddressP.new(2,1), IntP.new(2))
run.set_cell("3", CellAddressP.new(2,0), IntP.new(3))
run.set_cell(source, CellAddressP.new(0, 0), if_test)
cell = Runtime.new(grid).get_cell(CellAddressP.new(0,0))
puts
puts "GRID SOURCE:"
puts cell.code
puts
puts "SERIALIZED:"
puts "#{if_test.traverse(ser, Runtime.new(grid))}"
puts "EVALUATED:"
puts "#{if_test.traverse(eva, Runtime.new(grid)).inspect}"