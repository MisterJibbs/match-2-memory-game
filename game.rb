require_relative 'board'
require 'pry'

class MemoryGame
    attr_reader :board, :previous_guess
    
    def initialize(n)
        @board = Board.new(n)
        @previous_guess = nil
    end

    def over?
        board.won?
    end
    
    def play
        board.render
        make_move
    end

    def get_move
        guessed_pos = gets.chomp.split.map(&:to_i)  # => [x,y]
    end

    def valid_move?(guessed_pos)
        if guessed_pos == @previous_guess
            puts "You just guessed that."
            return false
        end

        card_is_already_revealed = board[guessed_pos].revealed
        if card_is_already_revealed
            puts "That card is already revealed."
            return false
        end

        true
    end

    def make_move
        @previous_guess = nil

        guessed_pos = false
        until guessed_pos
            guessed_pos = self.get_move

            unless valid_move?(guessed_pos)
                guessed_pos = false
            end
        end

        board.reveal(guessed_pos)
        @previous_guess = guessed_pos

        board.render

        second_guess = false
        until second_guess
            second_guess = self.get_move

            unless valid_move?(second_guess)
                second_guess = false
            end
        end

        if board[second_guess] == board[@previous_guess]
            board.reveal(second_guess)
            board.render
            puts "Nice! Press enter to continue"
            return gets
        else
            board.reveal(second_guess)
            board.render
            puts "Wrong! Press enter to continue"
            board.hide(previous_guess)
            board.hide(second_guess)
            return gets
        end
    end

end

game = MemoryGame.new(4)

until game.over?
    game.play
end

puts "you win!"
