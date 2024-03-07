require 'colorize'
system "clear"

class Game
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
    def initialize
        generate_secret
        @board = Board.new(@secret, @@color_ids)
        guess
        @board.show
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
                    r = rand(1..colors-1)
                end
            end
            @secret << r
        }
    end

    def guess
        puts 'Guess a combination. Your choices are: '
        choices
        input = gets.chomp.upcase
        until input.length == 4 && input.chars.all? { |x| @@color_ids.keys.include?(x) }
            puts 'Invalid combination. Please guess a combination using the provided colors: '
            choices
            input = gets.chomp.upcase
        end
        puts
        @board.add(input)
    end

    def choices
        @@color_ids.each do |key, _|
            print " #{key} ".colorize(:background => String.colors[@@color_ids[key]])
        end
        puts
    end

end

class Board

    def initialize(secret, color_ids, width = 4, length = 10)
        @@color_ids = color_ids
        @secret = secret
        puts "secret: " + @secret.to_s
        secret.each{|x| print (" " + @@color_ids.keys[x] + " ").colorize(:background => String.colors[x])}
        puts
        @board = []
        @board << ["R", "G", "Y", "P"]
        @board << ["W", "Y", "P", "X"]
        show
    end
    
    def match(row, secret)
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
            print(' ')
            match(row, @secret)
            puts ""
        end
    end

    def add(input)
        @board << input.chars
    end

end

Game.new