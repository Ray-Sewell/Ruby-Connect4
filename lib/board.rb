class Board
    attr_reader :state, :board
    def initialize
        @@DIAGONAL_RIGHT = [[2,0,4],[1,0,5],[0,0,6],[0,1,6],[0,2,5],[0,3,4]]
        @@DIAGONAL_LEFT = [[0,3,4],[0,4,5],[0,5,6],[0,6,6],[1,6,5],[2,6,4]]
        @board = Array.new(6) {Array.new(7)}
        @state = :p1
    end
    def place(pos, token)
        prev_i = nil
        @board.each_with_index do |row, i|
            if row[pos].nil?
                prev_i = i
            end
        end
        if prev_i.nil?
            puts "This column is full! Please enter another column!"
            return false
        else
            puts `clear`
            puts "#{translate(token)} dropped at #{pos + 1}!"
            @board[prev_i][pos] = token
            @state = check_state
            return true
        end
    end
    def check_state
        horizontal_win?
        vertical_win?
        diagonal_win?(@@DIAGONAL_RIGHT, 1, 1)
        diagonal_win?(@@DIAGONAL_LEFT, 1, -1)
        board_full?
        case @state
        when :p1
            return :p2
        when :p2
            return :p1
        else
            return nil
        end
    end
    def board_full?
        @board.each do |row|
            row.each do |token|
                if token.nil?
                    return false
                end
            end
        end
        puts "Board is full, draw!"
        @state = nil
        return true
    end
    def horizontal_win?
        @board.each do |row|
            row_string = ""
            row.each do |token|
                if token.nil?
                    row_string.concat("n")
                else
                    row_string.concat(token.to_s)
                end
            end
            if win?(row_string)
                return true
            end
        end
        return false
    end
    def vertical_win?
        i = 0
        7.times do
            ii = 0
            column_string = ""
            6.times do
                column_string.concat(find_token(ii,i))
                ii += 1
            end
            if win?(column_string)
                return true
            end
            i += 1
        end
        return false
    end
    def diagonal_win?(instructions, y, x)
        instructions.each do |instruction|
            diagonal_string = ""
            step_y = instruction[0]
            step_x = instruction[1]
            instruction[2].times do
                diagonal_string.concat(find_token(step_y,step_x))
                step_y += y
                step_x += x
            end
            if win?(diagonal_string)
                return true
            end
        end
        return false
    end
    def find_token(y,x)
        if @board[y][x].nil?
            return "n"
        else
            return @board[y][x].to_s
        end
    end
    def win?(string)
        if string.include? "1111"
            puts "#{translate(1)} wins!"
            @state = nil
            return true
        elsif string.include? "2222"
            puts "#{translate(2)} wins!"
            @state = nil
            return true
        end
        return false
    end
    def pretty_print
        @board.each do |row|
            print "\e[34m┃ \e[0m"
            row.each do |token|
                print "#{translate(token)} "
            end
            puts "\e[34m┃\e[0m"
        end
        puts "\e[34m┣━━━━━━━━━━━━━━━┫\e[0m"
        puts "  1 2 3 4 5 6 7"; puts
    end
    def translate(val)
        case val
        when nil
            return "\e[34m┄\e[0m"
        when 1
            return "\e[31m▆\e[0m"
        when 2
            return "\e[33m▆\e[0m"
        else
            return "\e[31mE\e[0m"
        end
    end
end