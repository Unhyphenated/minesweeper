require_relative "board.rb"

class Minesweeper
    attr_reader :size, :board
    def initialize(size=9)
        @board = Board.new(size)
        @size = size
        play
    end

    def pos_prompt
        puts "Please enter a position you'd like to uncover (e.g., 2, 1)."
        print "> "
    end

    def flag_prompt
        puts "Type 'F' if you would like to flag this position."
        print "> "
    end

    def get_user_position
        pos = nil
    
        until valid_position?(pos) && pos
            pos_prompt
            pos = gets.chomp.split(",").map(&:to_i)
        end

        pos
    end

    def get_user_flag
        flag = nil

        flag_prompt

        until valid_flag?(flag) && flag
            flag = gets.chomp
        end

        flag
    end

    def valid_position?(pos)
        pos.is_a?(Array) &&
        pos.count == 2 &&
        pos.each { |ele| ele.between?(0, size) }
    end

    def valid_flag?(flag)
        flag.is_a?(String) &&
        flag.length == 1
    end

    def reveal_square(pos, flag)
        board.reveal(pos)
        board.safe_squares.delete(pos)

        if flag == "F"
            board.flag(pos)
        end

        board.display

    end

    def play
        until board.won?

            board.display

            pos = get_user_position
            flag = get_user_flag
            reveal_square(pos, flag)
        end

    end

end

m = Minesweeper.new