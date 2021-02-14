require_relative("board.rb")

class User
    def initialize(board, token)
        @board = board
        @token = token
    end
    def turn
        puts "Where would you like to drop?"
        state = :on
        until state.nil?
            input = gets.chomp.to_i
            if input.between?(1,7)
                if @board.place(input - 1, @token)
                    state = nil
                end
            else
                puts "That's not a valid position! Please type a number between  1-7!"
            end
        end
    end
end

class Computer < User
    def turn
        state = :on
        until state.nil?
            if @board.place(rand(7), @token)
                state = nil
            end
        end
    end
end