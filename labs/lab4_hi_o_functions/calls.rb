#!/usr/bin/env ruby
# Jack Milman

teams = [["Fern", "Wilbur", "Templeton"], ["Milo", "Addie", "Doc"]]
p teams.map{ |team| team[0]} 

files = ["test.txt", "test2.txt", "test3.txt"]
p files.filter{ |file| File.exist?(file)}.size == files.size

tokens = ["abc", "aba", "bcd", "bcdb", "asaowid", "iini"]
p tokens.filter{ |token| token[0] == token[token.size - 1]}

message = "abcd123efg"
p message.split('').filter{ |char| "0123456789".include?(char)}

entries = ["thing", "thing2", "thing3", nil]
p entries.filter{ |entry| entry == nil}.size > 0

asciis = ["0", "1", "2", "3", "4", "5"]
p asciis.inject{ |output, ascii| output + ascii}

xs = [1, 2, -3, 4, -5, 0, 7]
p xs.map{ |x| 
    if x < 0
        '-'
    elsif x == 0
        '0'
    else
        '+'
    end
}

names = ["allen", "larry", "moe", "curly"]
bunglers = ["larry", "moe", "curly"]
p names.filter{ |name| !bunglers.include?(name)}