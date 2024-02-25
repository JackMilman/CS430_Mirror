class Point
    attr_accessor :x
    attr_accessor :y

    def initialize(x, y)
        @x = x
        @y = y
    end

    def to_s
        "(#{@x}, #{@y})"
    end
end

class Bounds
    attr_accessor :min_x
    attr_accessor :max_x
    attr_accessor :min_y
    attr_accessor :max_y
    
    def empty?
        @min_x == nil && @max_x == nil && @min_y == nil && @max_y == nil
    end

    def enclose(point)
        if empty?
            @min_x = point.x
            @max_x = point.x
            @min_y = point.y
            @max_y = point.y
        end
        if point.x < @min_x
            @min_x = point.x
        elsif point.x > @max_x
            @max_x = point.x
        end
        if point.y < @min_y
            @min_y = point.y
        elsif point.y > @max_y
            @max_y = point.y
        end
        return nil
    end

    def to_s
        "(#{@min_x}, #{@min_y}), (#{@max_x}, #{@min_y}), (#{@max_x}, #{@max_y}), (#{@min_x}, #{@max_y})"
    end
end

input_args = ARGV
if input_args.length != 1
    puts "ERROR: NUMBER OF ARGUMENTS != 1"
    exit
end
in_file = File.read(input_args[0])
file_lines = in_file.lines

points = file_lines.map{|line| Point.new(line.split(',')[0].to_i, line.split(',')[1].to_i)}

bounds = Bounds.new

points.each {|point| bounds.enclose(point)}
puts bounds.to_s