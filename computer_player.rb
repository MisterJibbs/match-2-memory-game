class ComputerPlayer
    attr_accessor :prev_pos, :known_cards, :matched_cards
    attr_reader   :board_size

    def initialize(board_size = 4)
        @board_size    = board_size
        @known_cards   = {}
        @matched_cards = {}
        @prev_pos      = nil
    end

    def get_input
        if known_cards_contain_a_pair
            pick_pair_position
        else
            random_guess
        end
    end

    def pick_pair_position
        if first_guess?
            find_pos_of_1st_card
        else
            find_pos_of_2nd_card
        end
    end

    def random_guess
        guess = [rand(@board_size), rand(@board_size)]
        guess = [rand(@board_size), rand(@board_size)] until valid_guess?(guess)
        
        return guess
    end

    def receive_known_card(pos, value)
        @known_cards[pos] = value
    end
    
    def receive_matched_cards(pos_1, pos_2)
        @matched_cards[pos_1] = true
        @matched_cards[pos_2] = true
        @known_cards.delete(pos_1)
        @known_cards.delete(pos_2)
    end

    # Beautify Methods
    
    def known_cards_contain_a_pair
        count = Hash.new(0)
        @known_cards.values.each { |value| count[value] += 1 }
        return count.values.any?(2)
    end
    
    def first_guess?
        @prev_pos == nil
    end
    
    def find_pos_of_1st_card
        swapped = Hash.new { |h,k| h[k] = [] }
        
        @known_cards.each { |pos, value| swapped[value] << pos }
        swapped = swapped.values.sort_by { |num_positions| num_positions.count }
        
        locations_of_pair = swapped[-1]
        pos_of_1st_card   = locations_of_pair[0]
    end
    
    def find_pos_of_2nd_card
        prev_val        = @known_cards[@prev_pos]
        pos_of_2nd_card = @known_cards.find { |pos, value| pos != @prev_pos && value == prev_val }[0]
    end

    def valid_guess?(guess)
        guess != @prev_pos && 
        @known_cards.keys.none?(guess) && 
        @matched_cards.keys.none?(guess)
    end
end