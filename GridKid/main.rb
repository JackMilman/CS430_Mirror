# #!usr/bin/env ruby
require_relative './ast.rb'

added = Ast::Add.new(Ast::Integer.new(1), Ast::Integer.new(2))

text = added.traverse(Ast::Serializer.new, nil)
print (text)