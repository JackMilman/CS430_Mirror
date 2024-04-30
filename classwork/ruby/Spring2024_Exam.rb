# args = ARGV
# string1 = args[0]
# string2 = args[1]
# puts string1, string2
# use_1 = false
# if string1.length >= string2.length
#     use_1 = true
# end
# range = 0
# if use_1
#     range = string1.length
# else
#     range = string2.length
# end
# for i in 0...range
#     if i < range and string1[i] == string2[i]
#         print (" ")
#     else
#         print ("^")
#     end
# end
# puts



def survey(votes)
    votes.split('').inject(0){|sum, vote|
        if vote == '-'
            sum - 1
        elsif vote == '+'
            sum + 1
        else
            sum + 0
        end
    }
end

puts survey('----0')
puts survey('+-+')

class Date
    def initialize(year, month, day)
        @year = year
        @month = month
        @day = day
    end

    def year
        @year
    end

    def month
        @month
    end

    def day
        @day
    end
end

def birthday_buddies(target, dates)
    results = dates.map{|date| Date.new(date[0..3].to_i, date[4..5].to_i, date[6..7].to_i)}
    results.filter{|result| (target.month == result.month) and (target.day == result.day)}
end

target = Date.new(1865, 4, 15)
p birthday_buddies(target, %w{20030415 20041009 20010415})



def sift(ranges, numbers)
    ranges.map { |range|
        numbers.filter {|number| range.member?(number)}
    }
end

p sift([5..7, 7..20], [7, 0, 5, 15, 4, 6])



def int_to_hash(value)
    if value < 1000
        {ones: value % 10, tens: (value % 100 / 10), hundreds: (value % 1000 / 100)}
    end
end

def hash_to_int(value)
    hundreds = value[:hundreds] * 100
    tens = value[:tens] * 10
    hundreds + tens + value[:ones]
end

i_h = int_to_hash(583)
p i_h
p hash_to_int(i_h)



class Connector
    def initialize
        @connections = Hash.new
    end

    def connect(e1, e2)
        if @connections[e1] == nil
            @connections[e1] = Hash.new
        end
        if @connections[e2] == nil
            @connections[e2] = Hash.new
        end
        @connections[e1][e2] = e1
        @connections[e2][e1] = e2
    end

    def disconnect(e1, e2)
        if @connections[e1] != nil and @connections[e2] != nil
            @connections[e1].delete(e2)
            @connections[e2].delete(e1)
        end
    end

    def connected?(e1, e2)
        @connections[e1] != nil and @connections[e2] != nil and @connections[e1][e2] != nil and @connections[e2][e1] != nil
    end

    def popularity(e1)
        if @connections[e1] != nil
            @connections[e1].size
        else
            0
        end
    end

end

c = Connector.new
s1 = "name1"
s2 = "name2"
c.connect(s1, s2)
p c.connected?(s1, s2)
p c.popularity(s1)
c.disconnect(s1, s2)
p c.connected?(s1, s2)
p c.popularity(s1)