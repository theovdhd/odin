require 'colorize'
system "clear"

class Game
    def initialize
        generate_secret
        @board = Board.new(@secret)
    end

    private

    def generate_secret(size = 4, colors = 8, unique = true)
        if unique && size > colors 
            puts 'Error. Size cannot be larger than colors if unique is set to true.' 
            abort
        end
        @secret = []
        size.times{
            r = rand(0..colors-1)
            if unique
                while @secret.include?(r)
                    r = rand(1..colors)
                end
            end
            @secret << r
        }
        puts "secret: " + @secret.to_s
    end


end

class Board
    @@color_ids = {
        'X' => 0,
        'R' => 1,
        'G' => 2,
        'Y' => 3,
        'B' => 4,
        'P' => 5,
        'C' => 6,
        'W' => 7
    }
    puts @@color_ids[7]
    def initialize(secret, width = 4, length = 10)
        @secret = secret
        @board = []
        @board << ["R", "G", "Y", "P"]
        @board << ["W", "Y", "P", "X"]
        show
    end

    def match(row, secret)
        puts "row: " + row.to_s
        exact_match = 0
        color_match = 0
        secret.each_with_index do |s, i|
            if s == @@color_ids[row[i]]   
                exact_match += 1
            end
        end
        puts exact_match    


    end

    def show
        @board.each do |row|
            row.each{|x| print (" " + x + " ").colorize(:background => String.colors[@@color_ids[x]])}
            match(row, @secret)
            puts ""
        end
    end
end

Game.new