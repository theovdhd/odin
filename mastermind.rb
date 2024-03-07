require 'colorize'

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
        win = false
        until win
            guess
            win = @board.show
        end
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
        secret.each{|x| print (" " + @@color_ids.keys[x] + " ").colorize(:background => String.colors[x])}
        puts
        @board = []
        show
    end
    
    def match(row, secret)
        #puts row.to_s
        #puts secret.to_s
        exact_match = 0
        color_match = 0
        secret.each_with_index do |s, i|            
            if s == @@color_ids[row[i]]   
                exact_match += 1
            elsif secret.include?(@@color_ids[row[i]])
                color_match += 1
            end
        end
        return exact_match, color_match
    end

    def show
        system "clear"
        @board.each do |row|
            row.each{|x| print (" " + x + " ").colorize(:background => String.colors[@@color_ids[x]])}
            print(' ')
            @exact_match, color_match = match(row, @secret)
            print ' ' + @exact_match.to_s + ' | ' + color_match.to_s
            puts puts
        end

        if @exact_match == 4
            return true
        else
            return false
        end
    end

    def add(input)
        @board << input.chars
    end

end

Game.new