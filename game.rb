require_relative 'computer_player'
require_relative 'human_player'
require_relative 'board'
require_relative 'prompt'

prompt = prompt_user

class MemoryGame
    attr_accessor :prev_pos
    attr_reader   :player, :board

    def initialize(player, board_size = 4)
        @player   = player
        @board    = Board.new(board_size)
        @prev_pos = nil
    end

    def play
        until board.won?
            board.render
            make_move
        end

        win_announcement_UI
    end

    def make_move
        new_pos = get_player_input

        player.receive_known_card(new_pos, board[new_pos].value)

        reveal_and_render(new_pos)

        compare_pos(@prev_pos, new_pos)

        sleep 1
    end

    def get_player_input
        new_pos = player.get_input
        new_pos = player.get_input until valid_move?(new_pos)

        return new_pos
    end 

    def valid_move?(new_pos)   # => [4,7]
        return false if new_pos == nil

        new_pos != @prev_pos && 
            new_pos.is_a?(Array) && 
            new_pos.count == 2 && 
            pos_within_grid?(new_pos) &&
            !@board.revealed?(new_pos)
    end

    def compare_pos(prev_pos, new_pos)
        if first_guess?
            return set_prev_pos_to_(new_pos)
        end

        if match?(prev_pos, new_pos)
            match_success_announcement_UI
            player.receive_matched_cards(prev_pos, new_pos)
        else
            match_failure_announcement_UI
            hide_both_positions(prev_pos,new_pos)
        end

        reset_prev_pos
    end

    # Beautify Methods

    def pos_within_grid?(pos)
        pos.each.all? { |el| el.between?(0, board.size-1) }
    end
 
    def reveal_and_render(new_pos)
        board.reveal(new_pos)
        board.render
    end
    
    def first_guess?
        prev_pos == nil
    end

    def set_prev_pos_to_(new_pos)
        self.prev_pos   = new_pos
        player.prev_pos = new_pos
    end

    def match?(pos_1, pos_2)
        board[pos_1] == board[pos_2]
    end

    def hide_both_positions(prev_pos, new_pos)
        board.hide(prev_pos)
        board.hide(new_pos)
    end

    def reset_prev_pos
        self.prev_pos   = nil
        player.prev_pos = nil
    end

    # UI Methods

    def win_announcement_UI
        puts
        puts "\t╔══════════╗"
        puts "\t║ You Win! ║"
        puts "\t╚══════════╝"
        puts
    end

    def match_success_announcement_UI
        puts "It's a match!"
    end

    def match_failure_announcement_UI
        puts "Sorry, try again."
    end
end

# Play as user
if __FILE__ == $PROGRAM_NAME && prompt == "human"
    game = MemoryGame.new(HumanPlayer.new)
    game.play
end

# Play as AI
if __FILE__ == $PROGRAM_NAME && prompt == "AI"
    game = MemoryGame.new(ComputerPlayer.new)
    game.play
end