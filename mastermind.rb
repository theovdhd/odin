require 'colorize'
system "clear"
color = :green
(0..17).each{|x| print "  ".colorize( :background => String.colors[x] )}



class Game
    def initialize
        generate_secret
        @board = Board.new()
    end

    private

    def generate_secret(size = 4, colors = 8, unique = true)
        if unique && size > colors 
            puts 'Error. Size cannot be larger than colors if unique is set to true.' 
            abort
        end
        @secret = []
        size.times{
            r = rand(1..colors)
            if unique
                while @secret.include?(r)
                    r = rand(1..colors)
                end
            end
            @secret << r
        }
    end


end

class Board
    def initialize(width = 4, length = 10)
        @board = Array.new(length) {Array.new(width)}
    end
end

Game.new