require_relative 'card'

class Board
    attr_reader :rows, :size

    def initialize(size)
        @rows = Array.new(size) { Array.new(size, :X) }
        @size = size
        self.populate
    end

    def [](pos)
        row, col = pos
        rows[row][col]
    end
    
    def []=(pos, value)
        row, col = pos
        rows[row][col] = value
    end

    def reveal(pos)
        self[pos].reveal
    end

    def hide(pos)
        self[pos].hide
    end

    def revealed?(pos)
        self[pos].revealed?
    end

    def populate
        deck = Card.shuffled_cards(size)
        add_cards_to_grid(deck)
    end

    def render
        system "clear"

        display_col_labels
        display_row_labels_and_grid
    end
        
    def won?
        rows.flatten.all? { |card| card.revealed? }
    end

    # Beautify Methods

    def add_cards_to_grid(deck)
        rows.each_index do |i|
            rows[i].each_index do |j|
                rows[i][j] = deck.pop
            end
        end
    end

    def display_col_labels
        puts "  " + (0...size).to_a.join(" ")
    end

    def display_row_labels_and_grid
        rows.each_with_index do |row, i| 
            print "#{i} "

            row.each do |card| 
                print "#{card.display} "
            end

            puts
        end

        puts
    end
end