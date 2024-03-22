module Interp

    class Token
        attr_reader :type
        attr_reader :source
        attr_reader :start_idx
        attr_reader :end_idx

        def initialize(type, source, start_idx, end_idx)
            @type = type
            @source = source
            @start_idx = start_idx
            @end_idx = end_idx
        end
    end

    #-------------------------------------------------------------------------#
    #----------------------------------Lexer----------------------------------#
    #-------------------------------------------------------------------------#
    class Lexer
        def initialize(code)
            @code = code
            @start_idx = 0
            @idx = 0
            @token_so_far = ""
            @tokens = []
        end

        # helper method for quickly resetting an individual lexer. Should
        # remove the need to create a brand new one every time.
        def reset(new_code)
            @code = new_code
            @start_idx = 0
            @idx = 0
            @token_so_far = ""
            @tokens = []
        end

        def lex
            def in_bounds
                @idx < @code.length
            end

            def has_digit
                # current character is a number value within 0-9
                in_bounds && @code[@idx].match?(/[0-9]/)
            end

            def has_letter
                # current character is a letter value within A-Z or a-z
                in_bounds && @code[@idx].match?(/[a-zA-Z]/)
            end

            def has(key)
                # current character equals passed key
                in_bounds && @code[@idx] == key
            end
            
            def advance
                # moves ahead without capturing the character: essentially ignores it
                @idx += 1
            end
    
            def capture
                # takes the current character and appends it to the current token then moves to the next character
                @token_so_far += @code[@idx]
                @idx += 1
            end
    
            def abandon
                # abandons whatever token we were working on
                @idx += 1
                @token_so_far = ""
                @start_idx = @idx
            end
    
            def emit_token(type)
                # shoots out whatever token we currently have into the void.
                @tokens << Token.new(type, @token_so_far, @start_idx, @idx - 1)
                @token_so_far = ""
                @start_idx = @idx
            end
            
            while @idx < @code.length
                if has(' ')
                    @start_idx += 1
                    advance
                elsif has_digit
                    while has_digit
                        capture
                    end
                    if has('.')
                        capture
                        while has_digit
                            capture
                        end
                        emit_token(:float_literal)
                    else
                        emit_token(:integer_literal)
                    end
                elsif has('+')
                    capture
                    emit_token(:add) # +
                elsif has('-')
                    capture
                    emit_token(:minus) # -
                elsif has('*')
                    capture
                    if has('*')
                        capture
                        emit_token(:exponentiate) # **
                    else
                        emit_token(:multiply) # *
                    end
                elsif has('/')
                    capture
                    emit_token(:divide) # /
                elsif has('%')
                    capture
                    emit_token(:modulo) # %
                elsif has('&')
                    capture
                    if has('&')
                        capture
                        emit_token(:and) # &&
                    else
                        emit_token(:bitwise_and) # &
                    end
                elsif has('|')
                    capture
                    if has('|')
                        capture
                        emit_token(:or) # ||
                    else
                        emit_token(:bitwise_or) # |
                    end
                elsif has('^')
                    capture
                    emit_token(:bitwise_xor) # ^
                elsif has('~')
                    capture
                    emit_token(:bitwise_not) # ~
                elsif has('!')
                    capture
                    if has('=')
                        capture
                        emit_token(:not_equals) # !=
                    else
                        emit_token(:not) # !
                    end
                elsif has('=')
                    capture
                    if has('=')
                        capture
                        emit_token(:equals) # ==
                    else
                        raise TypeError, "Expected ==, lexed: =#{@code[@idx]}"
                    end
                elsif has('<')
                    capture
                    if has('=')
                        capture
                        emit_token(:less_than_equal) # <=
                    elsif has('<')
                        capture
                        emit_token(:bitwise_left_shift) # <<
                    else
                        emit_token(:less_than) # <
                    end
                elsif has('>')
                    capture
                    if has('=')
                        capture
                        emit_token(:greater_than_equal) # >=
                    elsif has('>')
                        capture
                        emit_token(:bitwise_right_shift) # >>
                    else
                        emit_token(:greater_than) # >
                    end
                elsif has('F')
                    capture
                    begin
                        if has('a')
                            capture
                            if has('l')
                                capture
                                if has('s')
                                    capture
                                    if has('e')
                                        capture
                                        emit_token(:boolean_literal) # False
                                    else
                                        raise TypeError
                                    end
                                else
                                    raise TypeError
                                end
                            else
                                raise TypeError
                            end
                        else
                            raise TypeError
                        end
                    rescue TypeError
                        raise TypeError, "Improper Boolean token: #{@token_so_far}#{@code[@idx]}"
                    end
                elsif has('T')
                    capture
                    begin
                        if has('r')
                            capture
                            if has('u')
                                capture
                                if has('e')
                                    capture
                                    emit_token(:boolean_literal) # True
                                else
                                    raise TypeError
                                end
                            else
                                raise TypeError
                            end
                        else
                            raise TypeError
                        end
                    rescue TypeError
                        raise TypeError, "Improper Boolean token: #{@token_so_far}#{@code[@idx]}"
                    end
                elsif has('f')
                    capture
                    begin
                    if has('l')
                        capture
                        if has('o')
                            capture
                            if has('a')
                                capture
                                if has('t')
                                    capture
                                    emit_token(:float_cast) # float
                                else
                                    raise TypeError
                                end
                            else
                                raise TypeError
                            end
                        else
                            raise TypeError
                        end
                    else
                        raise TypeError
                    end
                    rescue TypeError
                        raise TypeError, "Improper cast token: #{@token_so_far}#{@code[@idx]}"
                    end
                elsif has('i')
                    begin
                        capture
                        if has('n')
                            capture
                            if has('t')
                                capture
                                emit_token(:int_cast) # int
                            else
                                raise TypeError
                            end
                        else
                            raise TypeError
                        end
                    rescue TypeError
                        raise TypeError, "Improper cast token: #{@token_so_far}#{@code[@idx]}"
                    end
                elsif has('m')
                    capture
                    begin
                        if has('a')
                            capture
                            if has('x')
                                capture
                                emit_token(:max_func) # max
                            else
                                raise TypeError
                            end
                        elsif has('i')
                            capture
                            if has('n')
                                capture
                                emit_token(:min_func) # min
                            else
                                raise TypeError
                            end
                        elsif has('e')
                            capture
                            if has('a')
                                capture
                                if has('n')
                                    capture
                                    emit_token(:mean_func) # mean
                                else 
                                    raise TypeError
                                end
                            else
                                raise TypeError
                            end
                        end
                    rescue TypeError
                        raise TypeError, "Not a real function: #{@token_so_far}#{@code[@idx]}"
                    end
                elsif has('s')
                    begin
                        capture
                        if has('u')
                            capture
                            if has('m')
                                capture
                                emit_token(:sum_func) # sum
                            else
                                raise TypeError
                            end
                        else
                            raise TypeError
                        end
                    rescue TypeError
                        raise TypeError, "Not a real function: #{@token_so_far}#{@code[@idx]}"
                    end
                elsif has('"')
                    capture
                    while in_bounds
                        capture
                        if has('"')
                            break
                        end
                    end
                    if has('"')
                        capture
                        emit_token(:string_literal)
                    else
                        raise TypeError, "Unclosed String: #{@token_so_far}#{@code[@idx]}"
                    end
                elsif has('#')
                    capture
                    emit_token(:hash) # #
                elsif has('[')
                    capture
                    emit_token(:left_bracket) # [
                elsif has(',')
                    capture
                    emit_token(:comma) # ,
                elsif has(']')
                    capture
                    emit_token(:right_bracket) # ]
                elsif has('(')
                    capture
                    emit_token(:left_parenthesis) # (
                elsif has(')')
                    capture
                    emit_token(:right_parenthesis) # )
                else
                    raise TypeError, "Unknown token: #{@code[@idx]}"
                end
            end

            return @tokens
        end
    end
    #-------------------------------------------------------------------------#
    #----------------------------------Parser---------------------------------#
    #-------------------------------------------------------------------------#
    class Parser
        def initialize(tokens)
            @tokens = tokens
            @token_idx = 0
            @handling_cell_ref = false
        end

        def parse
            def in_bounds
                @token_idx < @tokens.length
            end

            def has(type)
                in_bounds && @tokens[@token_idx].type == type
            end

            def advance
                @token_idx += 1
            end

            # This method seems to be necessary to deal with malformed code
            # like "1 - 1, 0]", since expression() will usually exit once
            # it reaches an token not handled by the recursive level it's at.
            def wrapper
                root = nil
                while in_bounds
                    root = expression
                end
                return root
            end

            def expression
                logic
            end

            def logic
                left = relational
                # start_i = left.indices[0]
                while has(:and)
                    start_i = left.indices[0]
                    if has(:and)
                        advance
                        right = relational
                        end_i = right.indices[1]
                        left = Ast::And.new(left, right)
                    end
                end
                return left
            end

            def relational
                left = bitwise
                # start_i = left.indices[0]
                while has(:equals) || has(:less_than_equal)
                    start_i = left.indices[0]
                    if has(:equals)
                        advance
                        right = bitwise
                        end_i = right.indices[1]
                        left = Ast::Equals.new(left, right, [start_i, end_i])
                    elsif has(:less_than_equal)
                        advance
                        right = bitwise
                        end_i = right.indices[1]
                        left = Ast::LessThanEqualTo.new(left, right, [start_i, end_i])
                    end
                end
                return left
            end
            
            def bitwise
                left = arithmetic
                # start_i = left.indices[0]
                while has(:bitwise_and) || has(:bitwise_or) || has(:bitwise_xor) || has(:bitwise_left_shift) || has(:bitwise_right_shift)
                    start_i = left.indices[0]
                    if has(:bitwise_and)
                        advance
                        right = arithmetic
                        end_i = right.indices[1]
                        left = Ast::BitwiseAnd.new(left, right, [start_i, end_i])
                    elsif has(:bitwise_or)
                        advance
                        right = arithmetic
                        end_i = right.indices[1]
                        left = Ast::BitwiseOr.new(left, right, [start_i, end_i])
                    elsif has(:bitwise_xor)
                        advance
                        right = arithmetic
                        end_i = right.indices[1]
                        left = Ast::BitwiseXor.new(left, right, [start_i, end_i])
                    elsif has(:bitwise_left_shift)
                        advance
                        right = arithmetic
                        end_i = right.indices[1]
                        left = Ast::BitwiseLeftShift.new(left, right, [start_i, end_i])
                    elsif has(:bitwise_right_shift)
                        advance
                        right = arithmetic
                        end_i = right.indices[1]
                        left = Ast::BitwiseRightShift.new(left, right, [start_i, end_i])
                    end
                end
                return left
            end

            def arithmetic
                left = multiplicative
                # start_i = left.indices[0]
                while has(:add) || has(:minus)
                    start_i = left.indices[0]
                    if has(:add)
                        advance
                        right = multiplicative
                        end_i = right.indices[1]
                        left = Ast::Add.new(left, right, [start_i, end_i])
                    elsif has(:minus)
                        advance
                        right = multiplicative
                        end_i = right.indices[1]
                        left = Ast::Subtract.new(left, right, [start_i, end_i])
                    end
                end
                return left
            end

            def multiplicative
                left = unary
                # start_i = left.indices[0]
                while has(:multiply) || has(:divide) || has(:modulo)
                    start_i = left.indices[0]
                    if has(:multiply)
                        advance
                        right = unary
                        end_i = right.indices[1]
                        left = Ast::Multiply.new(left, right, [start_i, end_i])
                    elsif has(:divide)
                        advance
                        right = unary
                        end_i = right.indices[1]
                        left = Ast::Divide.new(left, right, [start_i, end_i])
                    elsif has(:modulo)
                        advance
                        right = unary
                        end_i = right.indices[1]
                        left = Ast::Modulo.new(left, right, [start_i, end_i])
                    end
                end
                return left
            end

            def unary
                if has(:minus)
                    start_i = @tokens[@token_idx].start_idx
                    advance
                    right = exponential
                    end_i = right.indices[1]
                    return Ast::Negate.new(right, [start_i, end_i])
                elsif has(:bitwise_not)
                    start_i = @tokens[@token_idx].start_idx
                    advance
                    right = exponential
                    end_i = right.indices[1]
                    return Ast::BitwiseNot.new(right, [start_i, end_i])
                elsif has(:not)
                    start_i = @tokens[@token_idx].start_idx
                    advance
                    right = exponential
                    end_i = right.indices[1]
                    return Ast::Not.new(right, [start_i, end_i])
                else
                    return exponential
                end
            end

            def exponential
                left = atom
                # start_i = left.indices[0]
                if has(:exponentiate)
                    start_i = left.indices[0]
                    advance
                    right = exponential
                    end_i = right.indices[1]
                    left = Ast::Exponent.new(left, right, [start_i, end_i])
                end
                return left
            end

            def atom
                quark = @tokens[@token_idx]
                start_i = quark.start_idx
                if has(:integer_literal)
                    end_i = quark.end_idx
                    quark = Ast::IntP.new(quark.source.to_i, [start_i, end_i])
                    advance
                elsif has(:float_literal)
                    end_i = quark.end_idx
                    quark = Ast::FloatP.new(quark.source.to_f, [start_i, end_i])
                    advance
                elsif has(:boolean_literal)
                    end_i = quark.end_idx
                    quark = Ast::BooleanP.new(quark.source == "True", [start_i, end_i])
                    advance
                elsif has(:string_literal)
                    end_i = quark.end_idx
                    value = quark.source[1...quark.source.length - 1] # removes the "" marks
                    quark = Ast::StringP.new(value, [start_i, end_i])
                    advance
                elsif has(:left_parenthesis)
                    advance
                    quark = expression 
                    if not has(:right_parenthesis)
                        raise TypeError, "Expected closing Parentheses" # TODO: add index printed
                    end
                    advance
                elsif has(:hash)
                    advance
                    quark = handle_cell_address(start_i, true)
                elsif has(:left_bracket)
                    quark = handle_cell_address(start_i, false)
                elsif has(:comma)
                    if !@handling_cell_ref
                        raise TypeError, "Unexpected comma" #TODO: add index
                    end
                elsif has(:right_bracket)
                    if !@handling_cell_ref
                        raise TypeError, "Unexpected right Bracket" #TODO: add index
                    end
                end
                # puts "Index: #{start_i}"
                return quark
            end

            return wrapper
        end

        def handle_cell_address(start_i, r_val)
            result = nil
            @handling_cell_ref = true
            if has(:left_bracket)
                advance
                left = expression
                if has(:comma)
                    advance
                    right = expression
                    if not has(:right_bracket)
                        raise TypeError, "Expected closing Bracket" # TODO: add index printed
                    end
                    end_i = @tokens[@token_idx].end_idx
                    advance
                    if r_val
                        result = Ast::CellRValue.new(left, right, [start_i, end_i])
                    else
                        result = Ast::CellLValue.new(left, right, [start_i, end_i])
                    end
                else
                    raise TypeError, "Expected Comma for Cell Reference" # TODO: add index printed
                end
            else
                raise TypeError, "Expected opening Bracket for Cell Reference" # TODO: add index printed
            end
            @handling_cell_ref = false
            return result
        end
    end
end
