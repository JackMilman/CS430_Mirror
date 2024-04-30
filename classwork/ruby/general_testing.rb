class State
  attr_accessor :capital

  def initialize(value)
    @capital = value
  end
end

thing = State.new("thing")
puts thing.capital

def crank
  input = gets
  for i in 0...input.length
    for j in 0..i
      print(" ")
    end
    puts(input[i].upcase)
  end
end

# crank()

class Datums
  def initialize(nums)
    @nums = nums
  end
  
  def mean
    sum = 0.0
    @nums.each{|num| sum += num}
    sum.fdiv(@nums.length)
  end
  
  def median
    sorted = @nums.map{ |num| num}
    sorted = sorted.sort
    result = sorted[sorted.length / 2]
  end
  
  def numbers
    @nums
  end
end

d = Datums.new([101, 102])
p d.mean
p d.numbers