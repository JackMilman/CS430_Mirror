#!usr/bin/env ruby

# Jack Milman

module Html
    def self.make_tag(name, attr_hash, symbol)
        string = "<"
        string += name
        attr_hash.each do |key, value|
            string += " #{key}=\"#{value}\""
        end
        if (symbol == :empty)
            string += ">"
        elsif (symbol == :sandwich)
            string += "></#{name}>"
        elsif (symbol == :selfclose)
            string += " />"
        end
        return string
    end
end