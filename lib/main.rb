require_relative("player.rb")
require_relative("board.rb")

def game(board, p1, p2)
    puts `clear`
    state = :on
    until state.nil?
        puts
        board.pretty_print
        case board.state
        when :p1
            p1.turn
        when :p2
            p2.turn
        else
            puts "Press enter to return"
            gets
            state = nil
        end
    end
end

state = :on
until state.nil?
    puts `clear`
    puts "\e[33m     ██████  ██████  ███    ██ ███    ██ ███████  ██████ ████████     ██   ██ 
    ██      ██    ██ ████   ██ ████   ██ ██      ██         ██        ██   ██ 
    ██      ██    ██ ██ ██  ██ ██ ██  ██ █████   ██         ██        ███████ 
    ██      ██    ██ ██  ██ ██ ██  ██ ██ ██      ██         ██             ██ 
     ██████  ██████  ██   ████ ██   ████ ███████  ██████    ██             ██ 
    \e[0m"
    puts "How would you like to play?"
    puts "1. Human vs Human"
    puts "2. Human vs AI"
    puts "3. AI vs AI"
    puts "exit"; puts
    case input = gets.chomp
    when "1"
        board = Board.new
        player1 = User.new(board, 1)
        player2 = User.new(board, 2)
        game(board, player1, player2)
    when "2"
        board = Board.new
        player1 = User.new(board, 1)
        player2 = Computer.new(board, 2)
        game(board, player1, player2)
    when "3"
        board = Board.new
        player1 = Computer.new(board, 1)
        player2 = Computer.new(board, 2)
        game(board, player1, player2)
    when "exit"
        state = nil
        puts "Goodbye!"
    else
        puts "Invalid command!"
    end
end

