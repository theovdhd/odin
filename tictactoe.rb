class Game
    def initialize
        @board = Array.new(3) {Array.new(3, '_')}
        @turn = 'X'
        self.play()
    end

    def play
        self.show()
        @complete = false
        while not @complete
            move
            show
            check
            switch_turns
        end
        replay
    end

    def switch_turns
        @turn = @turn == 'X' ? 'O' : 'X'
    end

    def replay
        puts "Play again? (Y/N)"
        choice = gets.chomp.upcase
        if choice == 'Y'
            Game.new
        end
    end
    def show
        @board.each do |x|
            x.each do |y|
              print " #{y} "
            end
            2.times{puts}
        end
    end

    def move
        puts "#{@turn}'s turn."
        valid = false
        while not valid
            row, col = '',''
            while not [0, 1, 2].include?(row)
                puts "please specify row (0, 1 or 2)"
                row = gets.chomp.to_i
            end
            while not [0, 1, 2].include?(col)
                puts "please specify col (0, 1 or 2)"
                col = gets.chomp.to_i
            end
            valid = @board[row][col] == '_' ? true : false
            if not valid
                puts "Position already taken. Try again."
            end            
        end
        @board[row][col] = @turn
    end

    def check
        # check for winner
        @board.each do |arr| 
            u = arr.uniq
            if u.size <= 1 and (u[0] == @turn)
                puts "#{@turn} won!"
                @complete = true
            end
        end
        for i in (0..2) do
            if @board.all? {|item| item[i] == @turn } 
                puts "#{@turn} won!"
                @complete = true
            end
        end

        if @board[0][0] == @turn && @board[1][1] == @turn && @board[2][2] == @turn
            puts "#{@turn} won!"
            @complete = true
        end        
        
        if @board[0][2] == @turn && @board[1][1] == @turn && @board[2][0] == @turn
            puts "#{@turn} won!"
            @complete = true
        end 

        if !@board.flatten.include?('_')
            puts "Game finished with no winner."
            @complete = true
        end
    end
end

game = Game.new