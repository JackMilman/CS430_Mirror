#!/usr/bin/env ruby

def each_pair(items)
    i = 0
    while i < items.size - 1
        first = items[i]
        second = items[i + 1]
        # process first and second
        yield(first, second)
        i += 1
    end
end

items = [2, 5, 13, 7, 71, 12]
n_ups = 0
#each_pair(items) do |a, b|
items.each_cons(2) do |a, b|
    if b > a
        n_ups += 1
    end
end
puts n_ups

def each_zip(xs, ys)
    stop = [xs.size, ys.size].min
    for i in 0...stop
        yield(xs[i], ys[i])
    end
end

def zip(xs, ys)
    stop = [xs.size, ys.size].min
    results = []
    for i in 0...stop
        result = yield(xs[i], ys[i])
        results.push(result)
    end
    results
end

names = %w{Justin Luke Ethan Christian Aidan}
counts = [1, 5, 1, 1, 1]
each_zip(names, counts) do |name, count|
    puts "#{name} has #{count} siblings."
end

people = zip(names, counts) do |name, count|
    {name: name, count: count}
end
puts people

hash = {author: "Barbara Picard", title: "One is One", year: 1965}
keys = hash.keys.map{|key| "#{key}"}
puts keys

nums = [12, 16, 120]
nums.filter!{|num| num % 3 == 0 and num % 4 == 0}
puts nums