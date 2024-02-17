# #!usr/bin/env ruby
require_relative './ast.rb'

ser = Ast::Serializer.new

int1 = Ast::IntP.new(2)
int2 = Ast::IntP.new(-2)
intBad = Ast::IntP.new(4.5)
int_result1 = int1.traverse(ser, nil)
puts "Int 1: #{int_result1}"
int_result2 = int2.traverse(ser, nil)
puts "Int 2: #{int_result2}"
begin
int_resultBad = intBad.traverse(ser, nil)
puts "Int Bad: #{int_resultBad}"
rescue TypeError
    puts "Bad Int detected"
end


bool1 = Ast::BooleanP.new(true)
bool2 = Ast::BooleanP.new(false)
boolBad = Ast::BooleanP.new(3)
bool_result1 = bool1.traverse(ser, nil)
puts "Bool 1: #{bool_result1}"
bool_result2 = bool2.traverse(ser, nil)
puts "Bool 2: #{bool_result2}"
begin
bool_resultBad = boolBad.traverse(ser, nil)
puts "Bool Bad: #{bool_resultBad} Failed to detect"
rescue TypeError
    puts "Bad Bool detected"
end


float1 = Ast::FloatP.new(2.0)
float2 = Ast::FloatP.new(-2.7)
floatBad1 = Ast::IntP.new(false)
floatBad2 = Ast::IntP.new("blablabla")
float_result1 = float1.traverse(ser, nil)
puts "Float 1: #{float_result1}"
float_result2 = float2.traverse(ser, nil)
puts "Float 2: #{float_result2}"
begin
float_resultBad1 = floatBad1.traverse(ser, nil)
puts "Float Bad: #{float_resultBad1} Failed to detect"
rescue TypeError
    puts "Bad Float 1 detected"
end
begin
float_resultBad2 = floatBad2.traverse(ser, nil)
puts "Float Bad: #{float_resultBad2} Failed to detect"
rescue TypeError
    puts "Bad Float 2 detected"
end


add1 = Ast::Add.new(
    Ast::IntP.new(1), 
    Ast::IntP.new(2)
    )
add2 = Ast::Add.new(
    Ast::FloatP.new(1.5), 
    Ast::IntP.new(2)
    )
add3 = Ast::Add.new(
    Ast::FloatP.new(1.5), 
    Ast::FloatP.new(2.5)
    )
add4 = Ast::Add.new(
    Ast::IntP.new(1), 
    Ast::FloatP.new(2.5)
    )
compound_add = Ast::Add.new(
        Ast::Add.new(
            Ast::FloatP.new(0.5), 
            Ast::FloatP.new(2.5)
        ),
        Ast::IntP.new(3)
    )
bAdd = Ast::Add.new( # get it? Because bad
    Ast::BooleanP.new(true), 
    Ast::FloatP.new(2.5)
    )
add_result1 = add1.traverse(ser, nil)
puts "Add 1: #{add_result1}"
add_result2 = add2.traverse(ser, nil)
puts "Add 2: #{add_result2}"
add_result3 = add3.traverse(ser, nil)
puts "Add 3: #{add_result3}"
add_result4 = add4.traverse(ser, nil)
puts "Add 4: #{add_result4}"
compound_result = compound_add.traverse(ser, nil)
puts "Add Compound: #{compound_result}"
begin
bAdd_result = bAdd.traverse(ser, nil)
puts "bAdd: #{bAdd_result}"
rescue TypeError
    puts "bAdd TypeError detected"
end


mult1 = Ast::Multiply.new(
    Ast::IntP.new(7),
    Ast::FloatP.new(3)
)
mult2 = Ast::Multiply.new(
    Ast::Add.new(
        Ast::IntP.new(1),
        Ast::FloatP.new(2)
    ),
    Ast::IntP.new(3)
)
mult_prod1 = mult1.traverse(ser, nil)
puts "Mult 1: #{mult_prod1}"
mult_prod2 = mult2.traverse(ser, nil)
puts "Mult 2: #{mult_prod2}"



# TODO-list:
# EVALUATOR HOLY MOLY YOU GOTTA DO THE EVALUATOR EVERYTHING NEEDS THAT
# GOTTA MAKE THE GRID YOU CAN'T HAVE A GRIDKID WITHOUT A GRID THAT'S LIKE A BATMAN WITHOUT A JOKER

# String                --tests and structure
# Cell Address          --tests and structure
# Subtraction           --tests
# Division              --tests
# Modulo                --tests
# Exponentiation        --tests
# Negation              --tests
# And                   --tests
# Or                    --tests
# Not                   --tests
# Cell Lvalues          --tests and structure
# Cell Rvalues          --tests and structure
# Bitwise And           --tests
# Bitwise Or            --tests
# Bitwise Xor           --tests
# Bitwise Not           --tests
# Bitwise Left Shift    --tests
# Bitwise Right Shift   --tests
# Equal                 --tests
# Not Equal             --tests
# Less Than             --tests
# Less Than Equal To    --tests
# Greater Than          --tests
# Greater Than Equal To --tests
# Float-to-int          --tests
# Int-to-float          --tests
# Max                   --tests and structure
# Min                   --tests and structure
# Mean                  --tests and structure
# Sum                   --tests and structure