#!usr/bin/env ruby
require_relative './ast.rb'
require_relative './interp.rb'

# node = Ast::IntP.new(1)
# puts node

# puts "abcd".match? /\A[a-zA-Z'-]*\z/
# puts
# lexer_test1 = Interp::Lexer.new("5 <= 123")
# puts lexer_test1.has_letter
# lexer_test2 = Interp::Lexer.new("ABCD")
# puts lexer_test2.has_letter

# puts
# puts lexer_test1.has_digit
# puts lexer_test2.has_digit

tester = Interp::Lexer.new("")

# tester.reset("5 <= 32.0 - 25")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester.reset("5 + 2 * 3 % 4")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester.reset("1 + 1 * 8") # TODO: should be giving 9, is giving 16
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester.reset("2 ** 4 ** 2") # TODO: should be giving 65,536
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester.reset("5 False")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester.reset("5 Fals")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester.reset("\"sun\"")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester.reset("5 int")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester.reset("5 + 7.5")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester.reset("True")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester.reset("6 + -5")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester.reset("6 + (1 + -5)") # expected 2
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester.reset("6 + (1 + -5") # expected fail
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester.reset("1 - 1 0]")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester.reset("1 - 1 0]") # expected fail
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

# puts
# tester.reset("max([0, 0], [2, 1])")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}


# puts
# tester.reset("float(10) / 4.0")
# toks = tester.lex
# toks.each{|tok| puts tok.inspect}

puts
tester.reset("int(10.0) / 4.0")
toks = tester.lex
toks.each{|tok| puts tok.inspect}

puts
puts "TREE:"
parser = Interp::Parser.new(toks)
expr = parser.parse
puts expr.inspect
puts
puts "RESULTS:"
eval = Ast::Evaluator.new
puts expr.traverse(eval, nil).value