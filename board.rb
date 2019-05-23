require_relative 'card'
require 'pry'

class Board
    attr_reader :grid

    def initialize(n)
        @grid = Array.new(n) { Array.new(n, " ") }
        @size = n * n
        self.populate
    end

    def populate
        max_uniq_cards = @size / 2
        uniq_cards = {}
        alphabet = ("A".."Z").to_a

        while uniq_cards.length < max_uniq_cards
            rand_letter = alphabet.sample
            uniq_cards[Card.new(rand_letter)] = 0
        end

        grid.each_with_index do |row, row_i|
            row.each_with_index do |col, col_i|
                cards_yet_to_be_placed = uniq_cards.select { |card, count| count != 2 }.keys
                random_card_yet_to_be_placed = cards_yet_to_be_placed.sample
                grid[row_i][col_i] = Card.new(random_card_yet_to_be_placed.value)
                uniq_cards[random_card_yet_to_be_placed] += 1
            end
        end
    end

    def render
        system "clear"
        fully_labeled_grid.each { |row| puts row.join(" ") }
        puts
    end

    def fully_labeled_grid
        grid_with_letters = grid.map do |row|
            row.map do |card|
                if card.revealed
                    card.value
                else
                    " "
                end
            end
        end

        grid_with_labeled_rows = grid_with_letters.map.with_index { |row, i| [i] + row }
        col_labels = (0...grid_with_letters.length).map { |i| i }.unshift(" ")
        grid_with_labeled_rows.unshift(col_labels)
    end

    # def grid_with_labeled_rows
    #     grid.map.with_index { |row, i| [i] + row }
    # end

    # def col_labels
    #     labels = (0...grid.length).map { |i| i }
    #     labels.unshift(" ")
    # end

    def won?
        # true if all card are revealed
        grid.flatten.all? { |card| card.revealed == true }
    end

    def reveal(position) # => guessed_po = [x y]
        self[position].reveal
    end

    def hide(position)
        self[position].hide
    end

    def [](position)    # => [0, 1]
        row, col = position
        grid[row][col]
    end
    
    def []=(position, value)
        row, col = position
        grid[row][col] = value
    end

end


# The Board is responsible for keeping track of all your Cards. 
# You'll want a grid instance variable to contain Cards. 

# Useful methods:
#     #populate should fill the board with a set of shuffled Card pairs
#     #render should print out a representation of the Board's current state'
#     #won? should return true if all cards have been revealed.
#     #reveal should reveal a Card at guessed_pos 
#         (unless it's already face-up, in which case the method should do nothing). 
#         It should also return the value of the card it revealed (you'll see why later).