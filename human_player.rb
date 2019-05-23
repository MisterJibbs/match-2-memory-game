class HumanPlayer
    attr_writer :prev_pos

    def initialize
        @prev_pos = nil
    end
     
    def get_input
        ask_for_input_UI
        position = gets.chomp.split(",").map { |str| str.to_i }
    end

    # UI Methods

    def ask_for_input_UI
        puts  "Enter a position (i.e. 0,1)"
        print "> "
    end

    # Duck Methods

    def receive_known_card(pos, value)
    end

    def receive_matched_cards(pos_1, pos_2)
    end
end