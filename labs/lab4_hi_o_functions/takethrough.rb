#!/usr/bin/env ruby
# Jack Milman

def take_through(arr)
    result = []
    i = 0
    done = false
    while !done and i < arr.size
        done = yield(arr[i])
        result.append(arr[i])
        i += 1
    end
    return result
end

p take_through([10, 9, 8, 7, 5]) { |x| x == 8}

p take_through(('a'..'z').to_a) { |c| "dog".include?(c) }

sum = 0
p take_through((1..50).to_a) { |x|
  sum += x
  sum > 10
}

list = ["abcd", "bcde", "cdef", "defg"]
p take_through((list)) { |x| x.include?("def")}