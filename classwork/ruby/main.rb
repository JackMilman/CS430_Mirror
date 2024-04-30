require_relative './ast.rb'

meats = Ast::Set.new(['pork', 'chicken', 'beef', 'crab'])
plants = Ast::Set.new(['tofu' 'lentils', 'edamame'])
print_set = Ast::Print.new(meats)
print_size = Ast::Print.new(Ast::Size.new(meats))

text = print_set.traverse(Serializer.new)
puts text