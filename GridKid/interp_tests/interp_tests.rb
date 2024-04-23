#!usr/bin/env ruby
require_relative '../ast.rb'
require_relative '../interp.rb'

include Ast
include Interp

# node = IntP.new(1)
# puts node

# puts "abcd".match? /\A[a-zA-Z'-]*\z/
# puts
# lexer_test1 = Lexer.new("5 <= 123")
# puts lexer_test1.has_letter
# lexer_test2 = Lexer.new("ABCD")
# puts lexer_test2.has_letter

# puts
# puts lexer_test1.has_digit
# puts lexer_test2.has_digit

# tester = Lexer.new("")

# tester = Lexer.new("5 <= 32.0 - 25")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("5 + 2 * 3 % 4")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("1 + 1 * 8")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("2 ** 4 ** 2") # expected 65,536
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("5 False") # expect exception for an invalid expression
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("5 Fals") # expected fail
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("5  + 3 - (0 + 123) =? 10") # expected fail
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("\"sun\"")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("5 int")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("5 + 7.5")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("True")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("6 - -5")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("6 + (1 + -5)") # expected 2
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("6 + (1 + -5") # expected fail
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("#[1 - 1, 0]")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("#1 - 1, 0]") # expected fail
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("1 - 1 0]") # expected fail
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("max([0, 0], [2, 1])")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("max([0, 0] [2, 1])") # expected fail comma
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("max[0, 0], [2, 1])") # expected fail parens
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("mead([0, 0], [2, 1])") # expected fail function
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("(5 + 5) / 4.0")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("5 * (3 ** 2)")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("float(10) / 4.0")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("int(10.0) / 4.0")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("10.0 + 5.0)") # expected failure due to unpaired right parenthesis
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("10.0 + , 5.0") # expected failure due to unrelated comma
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester = Lexer.new("-6 ** 2")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

puts
puts "SOURCE:"
toks.each{|tok| print tok.source + " "}
print "\n"
puts "TREE:"
parser = Parser.new(toks)
expr = parser.parse
puts expr.inspect
# puts
# puts "RESULTS:"
# eval = Evaluator.new
# puts expr.traverse(eval, nil).value
