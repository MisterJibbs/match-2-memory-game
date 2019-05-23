class Card
    def self.shuffled_cards(board_size)
        values    = ("A".."Z").to_a
        num_pairs = (board_size ** 2) / 2

        deck_of_values = shuffled_deck_of_value_pairs(values, num_pairs)
        deck_of_cards  = deck_of_values.map { |value| Card.new(value) }
    end

    def self.shuffled_deck_of_value_pairs(values, num_pairs)
        deck = values.shuffle.take(num_pairs) * 2
        return deck.shuffle
    end

    attr_reader :value

    def initialize(value)
        @value    = value
        @revealed = false
    end

    def revealed?
        @revealed
    end

    def reveal
        @revealed = true
    end

    def hide
        @revealed = false
    end

    def display
        return @value if self.revealed?
        return " "
    end

    def ==(other_card)
        self.value == other_card.value
    end
end
