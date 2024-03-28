#!usr/bin/env ruby
require_relative './ast.rb'
require_relative './interp.rb'

eval = Ast::Evaluator.new
ser = Ast::Serializer.new
runt = Ast::Runtime.new(3)
lexer = Interp::Lexer.new
parser = Interp::Parser.new([])

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

    runtime.dump_state
    # expected structure:
    # |  0  |  12  |  -1  |
    # |  1  |   1  |  -2  |
    # |  0  | 2.5  |   0  |
end

lines_of_code = File.read("interp_tests/milestone_expected.txt").split("\n")
set_up_grid(runt)
puts

lines_of_code.each do |line_of_code|
    puts "Original: #{line_of_code}"
    lexer.reset(line_of_code)
    begin
        parser.reset(lexer.lex)
        expr = parser.parse
        # puts "Tree: #{expr.inspect}"
        puts "Serialized: #{expr.traverse(ser, runt)}"
        puts "Evaluated: #{expr.traverse(eval, runt).value}"
        puts
    rescue TypeError => err
        puts "Caught error:\n\t#{err.message}"
        puts
    end
end