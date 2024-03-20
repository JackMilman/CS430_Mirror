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

        # helper method
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

        def lex
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
                    emit_token(:plus) # +
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
                    if @idx + 3 < @code.length
                        if @code[@idx..@idx+3].match?("alse") # TODO: NOT YET DEALING WITH ABANDONING THE F, EVEN THOUGH IT'S BEEN CAPTURED.
                            capture
                            capture
                            capture
                            capture
                            emit_token(:boolean)
                        end
                    end
                elsif has('T')
                    capture
                    if @idx + 2 < @code.length
                        if @code[@idx..@idx+2].match("rue") # TODO: NOT YET DEALING WITH ABANDONING THE T, EVEN THOUGH IT'S BEEN CAPTURED.
                            capture
                            capture
                            capture
                            emit_token(:boolean)
                        end
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
                                    emit_token(:float_cast)
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
                                emit_token(:int_cast)
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
                                emit_token(:max_func)
                            else
                                raise TypeError
                            end
                        elsif has('i')
                            capture
                            if has('n')
                                capture
                                emit_token(:min_func)
                            else
                                raise TypeError
                            end
                        elsif has('e')
                            capture
                            if has('a')
                                capture
                                if has('n')
                                    capture
                                    emit_token(:mean_func)
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
                                emit_token(:sum_func)
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
                        emit_token(:string)
                    else
                        raise TypeError, "Unclosed String: #{@token_so_far}#{@code[@idx]}"
                    end
                elsif has('#')
                    capture
                    emit_token(:hash)
                elsif has('[')
                    capture
                    emit_token(:left_bracket)
                elsif has(',')
                    capture
                    emit_token(:comma)
                elsif has(']')
                    capture
                    emit_token(:right_bracket)
                elsif has('(')
                    capture
                    emit_token(:left_parenthesis)
                elsif has(')')
                    capture
                    emit_token(:right_parenthesis)
                else
                    raise TypeError, "Unknown token: #{@code[@idx]}"
                end
            end

            return @tokens
        end
    end

end