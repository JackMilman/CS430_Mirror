#!usr/bin/env ruby
require_relative './../ast.rb'

module ArithTests
    class Test
        def run_tests_serial(visitor, runtime)
            puts "---ADDITION---"
            add_tests(visitor, runtime)
            puts
            puts "---SUBTRACTION---"
            subtract_tests(visitor, runtime)
            puts
            puts "---MULTIPLICATION---"
            mult_tests(visitor, runtime)
            puts
            puts "---DIVISION---"
            div_tests(visitor, runtime)
            puts
            puts "---MODULO---"
            modulo_tests(visitor, runtime)
            puts
            puts "---EXPONENTIATION---"
            exponent_tests(visitor, runtime)
            puts
            puts "---NEGATION---"
            negate_tests(visitor, runtime)
            puts
        end

        def run_tests_eval(eval, ser, runtime)
            puts "---ADDITION---"
            add_tests_eval(eval, ser, runtime)
            puts
            puts "---SUBTRACTION---"
            subtract_tests_eval(eval, ser, runtime)
            puts
            puts "---MULTIPLICATION---"
            mult_tests_eval(eval, ser, runtime)
            puts
            puts "---DIVISION---"
            div_tests_eval(eval, ser, runtime)
            puts
            puts "---MODULO---"
            modulo_tests_eval(eval, ser, runtime)
            puts
            puts "---EXPONENTIATION---"
            exponent_tests_eval(eval, ser, runtime)
            puts
            puts "---NEGATION---"
            negate_tests_eval(eval, ser, runtime)
            puts
        end

        def add_tests(visitor, runtime)
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
            add_result1 = add1.traverse(visitor, runtime)
            puts "Add 1: #{add_result1}"
            add_result2 = add2.traverse(visitor, runtime)
            puts "Add 2: #{add_result2}"
            add_result3 = add3.traverse(visitor, runtime)
            puts "Add 3: #{add_result3}"
            add_result4 = add4.traverse(visitor, runtime)
            puts "Add 4: #{add_result4}"
            compound_result = compound_add.traverse(visitor, runtime)
            puts "Add Compound: #{compound_result}"
        end

        def subtract_tests(visitor, runtime)
            sub1 = Ast::Subtract.new(
            Ast::IntP.new(1), 
            Ast::IntP.new(2)
            )
            sub2 = Ast::Subtract.new(
                Ast::FloatP.new(1.5), 
                Ast::IntP.new(2)
                )
            sub3 = Ast::Subtract.new(
                Ast::FloatP.new(1.5), 
                Ast::FloatP.new(2.5)
                )
            sub4 = Ast::Subtract.new(
                Ast::IntP.new(1), 
                Ast::FloatP.new(2.5)
                )
            compound_sub = Ast::Subtract.new(
                    Ast::Add.new(
                        Ast::FloatP.new(0.5), 
                        Ast::FloatP.new(2.5)
                    ),
                    Ast::IntP.new(3)
                )
            sub_result1 = sub1.traverse(visitor, runtime)
            puts "Sub 1: #{sub_result1}"
            sub_result2 = sub2.traverse(visitor, runtime)
            puts "Sub 2: #{sub_result2}"
            sub_result3 = sub3.traverse(visitor, runtime)
            puts "Sub 3: #{sub_result3}"
            sub_result4 = sub4.traverse(visitor, runtime)
            puts "Sub 4: #{sub_result4}"
            compound_result = compound_sub.traverse(visitor, runtime)
            puts "Sub Compound: #{compound_result}"
        end
    
        def mult_tests(visitor, runtime)
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

            mult_prod1 = mult1.traverse(visitor, runtime)
            puts "Mult 1: #{mult_prod1}"
            mult_prod2 = mult2.traverse(visitor, runtime)
            puts "Mult 2: #{mult_prod2}"
        end

        def div_tests(visitor, runtime)
            div1 = Ast::Divide.new(
            Ast::IntP.new(7),
            Ast::FloatP.new(3)
            )
            div2 = Ast::Divide.new(
                Ast::Add.new(
                    Ast::IntP.new(1),
                    Ast::FloatP.new(2)
                ),
                Ast::IntP.new(3)
            )
            quot1 = div1.traverse(visitor, runtime)
            puts "Divide 1: #{quot1}"
            quot2 = div2.traverse(visitor, runtime)
            puts "Divide 2: #{quot2}"

        end

        def modulo_tests(visitor, runtime)
            modulo1 = Ast::Modulo.new(
            Ast::IntP.new(1), 
            Ast::IntP.new(2)
            )
            modulo2 = Ast::Modulo.new(
                Ast::FloatP.new(1.5), 
                Ast::IntP.new(2)
                )
            modulo3 = Ast::Modulo.new(
                Ast::FloatP.new(2.5), 
                Ast::FloatP.new(1.5)
                )
            modulo4 = Ast::Modulo.new(
                Ast::IntP.new(1), 
                Ast::FloatP.new(2.5)
                )
            compound_modulo = Ast::Modulo.new(
                    Ast::Add.new(
                        Ast::FloatP.new(0.5), 
                        Ast::FloatP.new(2.5)
                    ),
                    Ast::IntP.new(3)
                )
            modulo_result1 = modulo1.traverse(visitor, runtime)
            puts "Modulo 1: #{modulo_result1}"
            modulo_result2 = modulo2.traverse(visitor, runtime)
            puts "Modulo 2: #{modulo_result2}"
            modulo_result3 = modulo3.traverse(visitor, runtime)
            puts "Modulo 3: #{modulo_result3}"
            modulo_result4 = modulo4.traverse(visitor, runtime)
            puts "Modulo 4: #{modulo_result4}"
            compound_result = compound_modulo.traverse(visitor, runtime)
            puts "Modulo Compound: #{compound_result}"
        end

        def exponent_tests(visitor, runtime)
            exponent1 = Ast::Exponent.new(
            Ast::IntP.new(1), 
            Ast::IntP.new(2)
            )
            exponent2 = Ast::Exponent.new(
                Ast::FloatP.new(1.5), 
                Ast::IntP.new(2)
                )
            exponent3 = Ast::Exponent.new(
                Ast::FloatP.new(1.5), 
                Ast::FloatP.new(2.5)
                )
            exponent4 = Ast::Exponent.new(
                Ast::IntP.new(1), 
                Ast::FloatP.new(2.5)
                )
            compound_exponent = Ast::Exponent.new(
                    Ast::Add.new(
                        Ast::FloatP.new(0.5), 
                        Ast::FloatP.new(2.5)
                    ),
                    Ast::IntP.new(3)
                )
            exponent_result1 = exponent1.traverse(visitor, runtime)
            puts "Exponent 1: #{exponent_result1}"
            exponent_result2 = exponent2.traverse(visitor, runtime)
            puts "Exponent 2: #{exponent_result2}"
            exponent_result3 = exponent3.traverse(visitor, runtime)
            puts "Exponent 3: #{exponent_result3}"
            exponent_result4 = exponent4.traverse(visitor, runtime)
            puts "Exponent 4: #{exponent_result4}"
            compound_result = compound_exponent.traverse(visitor, runtime)
            puts "Exponent Compound: #{compound_result}"
        end

        def negate_tests(visitor, runtime)
            negate1 = Ast::Negate.new(Ast::IntP.new(1))
            negate2 = Ast::Negate.new(Ast::FloatP.new(3.7))
            compound_negate1 = Ast::Negate.new(
                Ast::Add.new(
                    Ast::IntP.new(1),
                    Ast::IntP.new(3)
                    )
                )
            compound_negate2 = Ast::Negate.new(
                Ast::Negate.new(
                    Ast::IntP.new(7)
                    )
                )
            negate_result1 = negate1.traverse(visitor, runtime)
            puts "Negate 1: #{negate_result1}"
            negate_result2 = negate2.traverse(visitor, runtime)
            puts "Negate 2: #{negate_result2}"
            compound_result1 = compound_negate1.traverse(visitor, runtime)
            puts "Compound Negate 1: #{compound_result1}"
            compound_result2 = compound_negate2.traverse(visitor, runtime)
            puts "Compound Negate 2: #{compound_result2}"
        end

        #---------------------------------------------------------------------#
        #---------------------------EVALUATOR TESTS---------------------------#
        #---------------------------------------------------------------------#
        def add_tests_eval(eval, ser, runtime)
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
            bAdd2 = Ast::Add.new( # get it? Because bad
                Ast::BooleanP.new(true), 
                5
            )
            add_result1 = add1.traverse(eval, runtime)
            puts "Add 1: #{add_result1.traverse(ser, runtime)}"
            add_result2 = add2.traverse(eval, runtime)
            puts "Add 2: #{add_result2.traverse(ser, runtime)}"
            add_result3 = add3.traverse(eval, runtime)
            puts "Add 3: #{add_result3.traverse(ser, runtime)}"
            add_result4 = add4.traverse(eval, runtime)
            puts "Add 4: #{add_result4.traverse(ser, runtime)}"
            compound_result = compound_add.traverse(eval, runtime)
            puts "Add Compound: #{compound_result}"
            begin
                bAdd_result1 = bAdd.traverse(eval, runtime)
                puts "bAdd1: MISSED AN ERROR Incompatible Operand"
            rescue TypeError
                puts "bAdd1 TypeError detected: Incompatible left operand (non-numeric value)"
            end
            begin
                bAdd_result2 = bAdd2.traverse(eval, runtime)
                puts "bAdd2: MISSED AN ERROR Incompatible Operand"
            rescue TypeError
                puts "bAdd2 TypeError detected: Incompatible left operand (Ruby primitive)"
            end
        end

        def subtract_tests_eval(eval, ser, runtime)
            sub1 = Ast::Subtract.new(
            Ast::IntP.new(1), 
            Ast::IntP.new(2)
            )
            sub2 = Ast::Subtract.new(
                Ast::FloatP.new(1.5), 
                Ast::IntP.new(2)
                )
            sub3 = Ast::Subtract.new(
                Ast::FloatP.new(1.5), 
                Ast::FloatP.new(2.5)
                )
            sub4 = Ast::Subtract.new(
                Ast::IntP.new(1), 
                Ast::FloatP.new(2.5)
                )
            compound_sub = Ast::Subtract.new(
                    Ast::Add.new(
                        Ast::FloatP.new(0.5), 
                        Ast::FloatP.new(2.5)
                    ),
                    Ast::IntP.new(3)
                )
            sub_bad1 = Ast::Subtract.new(
                Ast::BooleanP.new(true), 
                Ast::FloatP.new(2.5)
                )
            sub_bad2 = Ast::Subtract.new(
                Ast::BooleanP.new(true), 
                5
            )
            sub_result1 = sub1.traverse(eval, runtime)
            puts "Sub 1: #{sub_result1.traverse(ser, runtime)}"
            sub_result2 = sub2.traverse(eval, runtime)
            puts "Sub 2: #{sub_result2.traverse(ser, runtime)}"
            sub_result3 = sub3.traverse(eval, runtime)
            puts "Sub 3: #{sub_result3.traverse(ser, runtime)}"
            sub_result4 = sub4.traverse(eval, runtime)
            puts "Sub 4: #{sub_result4.traverse(ser, runtime)}"
            compound_result = compound_sub.traverse(eval, runtime)
            puts "Sub Compound: #{compound_result.traverse(ser, runtime)}"
            begin
                sub_bad_result1 = sub_bad1.traverse(eval, runtime)
                puts "sub_bad1: MISSED AN ERROR Incompatible Operand (non-numeric value)"
            rescue TypeError
                puts "sub_bad1 TypeError detected: Incompatible left operand (non-numeric value)"
            end
            begin
                sub_bad_result2 = sub_bad2.traverse(eval, runtime)
                puts "sub_bad2: MISSED AN ERROR Incompatible Operand (Ruby primitive)"
            rescue TypeError
                puts "sub_bad2 TypeError detected: Incompatible left operand (Ruby primitive)"
            end
        end
    
        def mult_tests_eval(eval, ser, runtime)
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
            bad_mult1 = Ast::Multiply.new(
                Ast::Add.new(
                    Ast::IntP.new(1),
                    Ast::FloatP.new(2)
                ),
                Ast::BooleanP.new(false)
            )
            mult_prod1 = mult1.traverse(eval, runtime)
            puts "Mult 1: #{mult_prod1.traverse(ser, runtime)}"
            mult_prod2 = mult2.traverse(eval, runtime)
            puts "Mult 2: #{mult_prod2.traverse(ser, runtime)}"
            begin
                bad_prod1 = bad_mult1.traverse(eval, runtime)
                puts "bad_mult: MISSED AN ERROR Incompatible Operand (Boolean)"
            rescue TypeError
                puts "bad_mult TypeError detected: Incompatible right operand (Boolean)"
            end
        end

        def div_tests_eval(eval, ser, runtime)
            div1 = Ast::Divide.new(
            Ast::IntP.new(7),
            Ast::FloatP.new(3)
            )
            div2 = Ast::Divide.new(
                Ast::Add.new(
                    Ast::IntP.new(1),
                    Ast::FloatP.new(2)
                ),
                Ast::IntP.new(3)
            )
            bad_div1 = Ast::Divide.new(
                Ast::Add.new(
                    Ast::IntP.new(1),
                    Ast::FloatP.new(2)
                ),
                Ast::BooleanP.new(false)
            )
            quot1 = div1.traverse(eval, runtime)
            puts "Divide 1: #{quot1.traverse(ser, runtime)}"
            quot2 = div2.traverse(eval, runtime)
            puts "Divide 2: #{quot2.traverse(ser, runtime)}"
            begin
                bad_quot1 = bad_div1.traverse(eval, runtime)
                puts "bad_div: MISSED AN ERROR Incompatible Operand (Boolean)"
            rescue TypeError
                puts "bad_div TypeError detected: Incompatible right operand (Boolean)"
            end
        end

        def modulo_tests_eval(eval, ser, runtime)
            modulo1 = Ast::Modulo.new(
            Ast::IntP.new(1), 
            Ast::IntP.new(2)
            )
            modulo2 = Ast::Modulo.new(
                Ast::FloatP.new(1.5), 
                Ast::IntP.new(2)
                )
            modulo3 = Ast::Modulo.new(
                Ast::FloatP.new(2.5), 
                Ast::FloatP.new(1.5)
                )
            modulo4 = Ast::Modulo.new(
                Ast::IntP.new(1), 
                Ast::FloatP.new(2.5)
                )
            compound_modulo = Ast::Modulo.new(
                    Ast::Add.new(
                        Ast::FloatP.new(0.5), 
                        Ast::FloatP.new(2.5)
                    ),
                    Ast::IntP.new(3)
                )
            bad_modulo1 = Ast::Modulo.new(
                Ast::BooleanP.new(true), 
                Ast::FloatP.new(2.5)
                )
            bad_modulo2 = Ast::Modulo.new(
                Ast::BooleanP.new(true), 
                5
            )
            modulo_result1 = modulo1.traverse(eval, runtime)
            puts "Modulo 1: #{modulo_result1.traverse(ser, runtime)}"
            modulo_result2 = modulo2.traverse(eval, runtime)
            puts "Modulo 2: #{modulo_result2.traverse(ser, runtime)}"
            modulo_result3 = modulo3.traverse(eval, runtime)
            puts "Modulo 3: #{modulo_result3.traverse(ser, runtime)}"
            modulo_result4 = modulo4.traverse(eval, runtime)
            puts "Modulo 4: #{modulo_result4.traverse(ser, runtime)}"
            compound_result = compound_modulo.traverse(eval, runtime)
            puts "Modulo Compound: #{compound_result.traverse(ser, runtime)}"
            begin
                bad_modulo_result1 = bad_modulo1.traverse(eval, runtime)
                puts "bad_modulo1: MISSED AN ERROR Incompatible Operand (non-numeric value)"
            rescue TypeError
                puts "bad_modulo1 TypeError detected: Incompatible left operand (non-numeric value)"
            end
            begin
                bad_modulo_result1 = bad_modulo2.traverse(eval, runtime)
                puts "bad_modulo2: MISSED AN ERROR Incompatible Operand (Ruby primitive)"
            rescue TypeError
                puts "bad_modulo2 TypeError detected: Incompatible left operand (Ruby primitive)"
            end
        end

        def exponent_tests_eval(eval, ser, runtime)
            exponent1 = Ast::Exponent.new(
            Ast::IntP.new(1), 
            Ast::IntP.new(2)
            )
            exponent2 = Ast::Exponent.new(
                Ast::FloatP.new(1.5), 
                Ast::IntP.new(2)
                )
            exponent3 = Ast::Exponent.new(
                Ast::FloatP.new(1.5), 
                Ast::FloatP.new(2.5)
                )
            exponent4 = Ast::Exponent.new(
                Ast::IntP.new(1), 
                Ast::FloatP.new(2.5)
                )
            compound_exponent = Ast::Exponent.new(
                    Ast::Add.new(
                        Ast::FloatP.new(0.5), 
                        Ast::FloatP.new(2.5)
                    ),
                    Ast::IntP.new(3)
                )
            bad_exponent1 = Ast::Exponent.new(
                Ast::BooleanP.new(true), 
                Ast::FloatP.new(2.5)
                )
            bad_exponent2 = Ast::Exponent.new(
                Ast::BooleanP.new(true), 
                5
            )
            exponent_result1 = exponent1.traverse(eval, runtime)
            puts "Exponent 1: #{exponent_result1.traverse(ser, runtime)}"
            exponent_result2 = exponent2.traverse(eval, runtime)
            puts "Exponent 2: #{exponent_result2.traverse(ser, runtime)}"
            exponent_result3 = exponent3.traverse(eval, runtime)
            puts "Exponent 3: #{exponent_result3.traverse(ser, runtime)}"
            exponent_result4 = exponent4.traverse(eval, runtime)
            puts "Exponent 4: #{exponent_result4.traverse(ser, runtime)}"
            compound_result = compound_exponent.traverse(eval, runtime)
            puts "Exponent Compound: #{compound_result.traverse(ser, runtime)}"
            begin
                bad_exponent_result1 = bad_exponent1.traverse(eval, runtime)
                puts "bad_exponent1: MISSED AN ERROR Incompatible Operand (non-numeric value)"
            rescue TypeError
                puts "bad_exponent1 TypeError detected: Incompatible left operand (non-numeric value)"
            end
            begin
                bad_exponent_result2 = bad_exponent2.traverse(eval, runtime)
                puts "bad_exponent2: MISSED AN ERROR Incompatible Operand (Ruby primitive)"
            rescue TypeError
                puts "bad_exponent2 TypeError detected: Incompatible left operand (Ruby primitive)"
            end
        end

        def negate_tests_eval(eval, ser, runtime)
            negate1 = Ast::Negate.new(Ast::IntP.new(1))
            negate2 = Ast::Negate.new(Ast::FloatP.new(3.7))
            compound_negate1 = Ast::Negate.new(
                Ast::Add.new(
                    Ast::IntP.new(1),
                    Ast::IntP.new(3)
                    )
                )
            compound_negate2 = Ast::Negate.new(
                Ast::Negate.new(
                    Ast::IntP.new(7)
                    )
                )
            bad_negate1 = Ast::Negate.new(Ast::BooleanP.new(false))
            bad_negate2 = Ast::Negate.new(Ast::StringP.new("bad :c"))
            negate_result1 = negate1.traverse(eval, runtime)
            puts "Negate 1: #{negate_result1.traverse(ser, runtime)}"
            negate_result2 = negate2.traverse(eval, runtime)
            puts "Negate 2: #{negate_result2.traverse(ser, runtime)}"
            compound_result1 = compound_negate1.traverse(eval, runtime)
            puts "Compound Negate 1: #{compound_result1.traverse(ser, runtime)}"
            compound_result2 = compound_negate2.traverse(eval, runtime)
            puts "Compound Negate 2: #{compound_result2.traverse(ser, runtime)}"
            begin
                bad_negate_result1 = bad_negate1.traverse(eval, runtime)
                puts "bad_negate1: MISSED AN ERROR Incompatible Operand (Boolean)"
            rescue TypeError
                puts "bad_negate1 TypeError detected: Incompatible left operand (Boolean)"
            end
            begin
                bad_negate_result2 = bad_negate2.traverse(eval, runtime)
                puts "bad_negate2:MISSED AN ERROR Incompatible Operand (String)"
            rescue TypeError
                puts "bad_negate2 TypeError detected: Incompatible left operand (String)"
            end
        end
    end
end