require 'net/http'
require 'uri'
require 'json'

def top_rhymes(word, score)
    body = Net::HTTP.get(URI.parse("https://rhymebrain.com/talk?function=getRhymes&word=#{word}"))
    j_body = JSON.parse(body)
    rhymes = j_body.map{|word| Rhyme.new(word["word"], word["score"])}
    return rhymes.filter{|rhyme| rhyme.score >= score}
end

class Rhyme
    attr_accessor :word
    attr_accessor :score

    def initialize(word, score)
        @word = word
        @score = score
    end
end

input_args = ARGV
if input_args.length != 2
    puts "ERROR, INCORRECT NUMBER OF ARGUMENTS: #{input_args.length}"
    puts "EXPECTED NUMBER: 2"
    exit
end
rhymes = top_rhymes(input_args[0], input_args[1].to_i)
rhymes.each{|rhyme| puts "#{rhyme.word}: #{rhyme.score}"}