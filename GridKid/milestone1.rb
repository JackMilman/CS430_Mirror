#!usr/bin/env ruby
require_relative './ast.rb'
require_relative './arithmetic_tests.rb'
require_relative './bitwise_tests.rb'
require_relative './logical_tests.rb'
require_relative './primitive_tests.rb'
require_relative './cell_tests.rb'

eval = Ast::Evaluator.new
ser = Ast::Serializer.new
size = 6
runtime = Ast::Runtime.new(size)
def set_up_grid(runtime)
    cell_0_0 = Ast::CellAddressP.new(0, 0)
    cell_0_1 = Ast::CellAddressP.new(0, 1)
    cell_0_2 = Ast::CellAddressP.new(0, 2)
    cell_0_3 = Ast::CellAddressP.new(0, 3)
    cell_0_4 = Ast::CellAddressP.new(0, 4)
    cell_0_5 = Ast::CellAddressP.new(0, 5)

    cell_1_0 = Ast::CellAddressP.new(1, 0)
    cell_1_1 = Ast::CellAddressP.new(1, 1)
    cell_1_2 = Ast::CellAddressP.new(1, 2)
    cell_1_3 = Ast::CellAddressP.new(1, 3)
    cell_1_4 = Ast::CellAddressP.new(1, 4)
    cell_1_5 = Ast::CellAddressP.new(1, 5)

    cell_2_0 = Ast::CellAddressP.new(2, 0)
    cell_2_1 = Ast::CellAddressP.new(2, 1)
    cell_2_2 = Ast::CellAddressP.new(2, 2)
    cell_2_3 = Ast::CellAddressP.new(2, 3)
    cell_2_4 = Ast::CellAddressP.new(2, 4)
    cell_2_5 = Ast::CellAddressP.new(2, 5)
    
    cell_3_0 = Ast::CellAddressP.new(3, 0)
    cell_3_1 = Ast::CellAddressP.new(3, 1)
    cell_3_2 = Ast::CellAddressP.new(3, 2)
    cell_3_3 = Ast::CellAddressP.new(3, 3)
    cell_3_4 = Ast::CellAddressP.new(3, 4)
    cell_3_5 = Ast::CellAddressP.new(3, 5)

    cell_4_0 = Ast::CellAddressP.new(4, 0)
    cell_4_1 = Ast::CellAddressP.new(4, 1)
    cell_4_2 = Ast::CellAddressP.new(4, 2)
    cell_4_3 = Ast::CellAddressP.new(4, 3)
    cell_4_4 = Ast::CellAddressP.new(4, 4)
    cell_4_5 = Ast::CellAddressP.new(4, 5)

    cell_5_0 = Ast::CellAddressP.new(5, 0)
    cell_5_1 = Ast::CellAddressP.new(5, 1)
    cell_5_2 = Ast::CellAddressP.new(5, 2)
    cell_5_3 = Ast::CellAddressP.new(5, 3)
    cell_5_4 = Ast::CellAddressP.new(5, 4)

    zero = Ast::IntP.new(0)
    one = Ast::IntP.new(1)
    two = Ast::FloatP.new(2.5)
    twelve = Ast::IntP.new(12)
    neg_one = Ast::IntP.new(-1)
    neg_two = Ast::IntP.new(-2)
    runtime.set_cell(cell_0_0, zero)
    runtime.set_cell(cell_0_1, twelve)
    runtime.set_cell(cell_0_2, neg_one)
    runtime.set_cell(cell_0_3, zero)
    runtime.set_cell(cell_0_4, zero)
    runtime.set_cell(cell_0_5, zero)

    runtime.set_cell(cell_1_0, one)
    runtime.set_cell(cell_1_1, one)
    runtime.set_cell(cell_1_2, neg_two)
    runtime.set_cell(cell_1_3, Ast::Add.new(
        Ast::CellRValue.new(
            Ast::IntP.new(0),
            Ast::IntP.new(1)
        ),
        Ast::CellRValue.new(
            Ast::IntP.new(1),
            Ast::IntP.new(2)
        ),
    ))
    #[0,1] + #[1,2]
    runtime.set_cell(cell_1_4, one)
    runtime.set_cell(cell_1_5, one)

    runtime.set_cell(cell_2_0, zero)
    runtime.set_cell(cell_2_1, two)
    runtime.set_cell(cell_2_2, zero)
    runtime.set_cell(cell_2_3, neg_two)
    runtime.set_cell(cell_2_4, neg_two)
    runtime.set_cell(cell_2_5, neg_two)

    runtime.set_cell(cell_3_0, zero)
    runtime.set_cell(cell_3_1, zero)
    runtime.set_cell(cell_3_2, zero)
    runtime.set_cell(cell_3_3, zero)
    runtime.set_cell(cell_3_4, zero)
    runtime.set_cell(cell_3_5, zero)

    runtime.set_cell(cell_4_0, zero)
    runtime.set_cell(cell_4_1, zero)
    runtime.set_cell(cell_4_2, zero)
    runtime.set_cell(cell_4_3, zero)
    runtime.set_cell(cell_4_4, zero)
    runtime.set_cell(cell_4_5, zero)

    runtime.set_cell(cell_5_0, zero)
    runtime.set_cell(cell_5_1, zero)
    runtime.set_cell(cell_5_2, zero)
    runtime.set_cell(cell_5_3, Ast::CellAddressP.new(2,3))
    runtime.set_cell(cell_5_4, zero)

    # expected structure:
    # 0:|  0  |  12  |  -1  |       0       |   0  |    0   |
    # 1:|  1  |   1  |  -2  |#[0,1] + #[1,2]|   1  |    1   |
    # 2:|  0  |   2  |   0  |      -2       |  -2  |   -2   |
    # 3:|  0  |   0  |   0  |       0       |   0  |    0   |
    # 4:|  0  |   0  |   0  |       0       |   0  |    0   |
    # 5:|  0  |   0  |   0  |    [2, 3]     |   0  |   nil  |
end
set_up_grid(runtime)

arith = Ast::Modulo.new(
    Ast::Add.new(
        Ast::Multiply.new(
            Ast::IntP.new(7),
            Ast::IntP.new(4)
        ),
        Ast::IntP.new(3)
    ),
    Ast::IntP.new(12)
)
puts
puts "Arith operation: #{arith.traverse(ser, runtime)}"
puts "Arith operation expected: 7, evaluated: #{arith.traverse(eval, runtime).traverse(ser, runtime)}"

rval_shift = Ast::BitwiseLeftShift.new(
    Ast::CellRValue.new(
        Ast::Add.new(
            Ast::IntP.new(1),
            Ast::IntP.new(1)
        ),
        Ast::IntP.new(4)
    ),
    Ast::IntP.new(3)
)
puts
puts "Rval Left Shift: #{rval_shift.traverse(ser, runtime)}"
puts "Rval Left Shift expected: -16, evaluated: #{rval_shift.traverse(eval, runtime).traverse(ser, runtime)}"

rval_comp = Ast::LessThan.new(
    Ast::CellRValue.new(
        Ast::IntP.new(0),
        Ast::IntP.new(0)
    ),
    Ast::CellRValue.new(
        Ast::IntP.new(0),
        Ast::IntP.new(1)
    )
)
puts
puts "Rval_comp: #{rval_comp.traverse(ser, runtime)}"
puts "Rval_comp expected: true, evaluated: #{rval_comp.traverse(eval, runtime).traverse(ser, runtime)}"

logic_comp = Ast::Not.new(
    Ast::GreaterThan.new(
        Ast::FloatP.new(3.3),
        Ast::FloatP.new(3.2)
    )
)
puts
puts "Logic_comp: #{logic_comp.traverse(ser, runtime)}}"
puts "Logic_comp expected: false, evaluated: #{logic_comp.traverse(eval, runtime).traverse(ser, runtime)}"

sum = Ast::Sum.new(
    Ast::CellLValue.new(
        Ast::IntP.new(1),
        Ast::IntP.new(2)
    ),
    Ast::CellRValue.new(
        Ast::IntP.new(5),
        Ast::IntP.new(3)
    )
)
puts
puts "Sum Rval: #{sum.traverse(ser, runtime)}"
puts "Sum Rval expected: 8, evaluated: #{sum.traverse(eval, runtime).traverse(ser, runtime)}"

cast = Ast::Divide.new(
    Ast::CastIntToFloat.new(
        Ast::IntP.new(7)
    ),
    Ast::IntP.new(2)
)
puts
puts "Cast Divide: #{cast.traverse(ser, runtime)}"
puts "Cast Divide expected: 3.5, evaluated: #{cast.traverse(eval, runtime).traverse(ser, runtime)}"

error1 = Ast::Exponent.new(
    Ast::StringP.new("^_^"),
    Ast::Add.new(
        Ast::IntP.new(10),
        Ast::FloatP.new(-7000.5)
    )
)
puts
puts "String arithmetic error: #{error1.traverse(ser, runtime)}"
begin
    puts "String arithmetic evaluated: #{error1.traverse(eval, runtime).traverse(ser, runtime)}"
rescue TypeError
    puts "Caught the incompatible operands error (String value for Arithmetic operation)"
end

error2 = Ast::Add.new(
    Ast::IntP.new(false),
    Ast::IntP.new(5)
)
puts
puts "Incompatible value error: #{error2.traverse(ser, runtime)}"
begin
    puts "Bad Int evaluated: #{error2.traverse(eval, runtime).traverse(ser, runtime)}"
rescue TypeError
    puts "Caught the incompatible operands error (Boolean value for IntP)"
end

error3 = Ast::CellAddressP.new(4, 65)
puts
puts "Index error for grid of size #{size}: #{error3.traverse(ser, runtime)}"
begin
    puts "Accessed out of bounds: #{runtime.get_cell(error3)}"
rescue IndexError
    puts "Caught the Index Error"
end

error4 = Ast::CellAddressP.new(5, 5)
puts
puts "Accessing an undefined cell error: #{error4.traverse(ser, runtime)}"
begin
    puts "Accessed undefined cell: #{runtime.get_cell(error4)}"
rescue TypeError
    puts "Caught the undefined cell access Error"
end