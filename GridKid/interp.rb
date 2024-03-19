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
            @tokens = []
        end

        def has_digit
            # current character is a number value within 0-9
            @code[@idx].match?(/[0-9]/)
        end

        def has_letter
            # current character is a letter value within A-Z or a-z
            @code[@idx].match?(/[a-zA-Z]/)
        end

        def has(key)
            # current character equals passed key
            @code[@idx].match?()
        end

        def lex
            token_so_far = ""

            def advance
                # moves ahead without capturing the character: essentially ignores it
                @idx += 1
            end
    
            def capture
                # takes the current character and appends it to the current token then moves to the next character
                token_so_far += @code[@idx]
            end
    
            def abandon
                # abandons whatever token we were working on
            end
    
            def emit_token
                # shoots out whatever token we currently have into the void.
            end

            while @idx < @code.length
                
            end
        end
    end

end