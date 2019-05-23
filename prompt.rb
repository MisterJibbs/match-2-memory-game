def prompt_user
    prompt = nil

    until prompt == "human" || prompt == "AI"
        display_prompt_UI
        prompt = gets.chomp
    end

    return prompt
end

def display_prompt_UI
    system "clear"
    puts   "Play as human or AI?"
    puts
    puts   "    human    AI"
    puts
    print  "> "
end