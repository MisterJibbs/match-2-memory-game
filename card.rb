class Card
    attr_reader :value, :revealed

    def initialize(value)
        @value = value
        @revealed = false
    end

    def display
        if revealed
            return @value
        else
            return " "
        end
    end

    def hide
        @revealed = false
    end

    def reveal
        @revealed = true
    end

    def ==(other_card)
        self.value == other_card.value
    end
end



# A Card has two useful bits of information: 

# its face value, and 
# whether it is face-up or face-down. 

# You'll want instance variables to keep track of this information. 

# You'll also want a method to display information about the card: 

# nothing when face-down, or 
# its value when face-up. 

# I also wrote #hide, #reveal, #to_s, and #== methods.