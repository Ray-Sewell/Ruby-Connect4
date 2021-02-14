require ("./lib/board.rb")

describe Board do
    subject(:board) { described_class.new }

    describe "#translate" do
        it "returns a colour value for pretty print" do
            expect(board.translate(0)).to eql("\e[31mE\e[0m")
            expect(board.translate([0,1,2])).to eql("\e[31mE\e[0m")
            expect(board.translate("E")).to eql("\e[31mE\e[0m")
            expect(board.translate(nil)).to eql("\e[34m┄\e[0m")
            expect(board.translate(1)).to eql("\e[31m▆\e[0m")
            expect(board.translate(2)).to eql("\e[33m▆\e[0m")
        end
    end
    describe "#place" do
        it "accepts a token and position" do
            expect(board.place(1, nil)).to eql(true)
            expect(board.place(1, 1)).to eql(true)
            expect(board.place(1, 2)).to eql(true)
        end
        it "places the token to the correct position" do
            board.place(0,"Test")
            5.times do board.place(6,"Inv") end
            board.place(6,"Test")
            expect(board.board[5][0]).to eql("Test")
            expect(board.board[0][6]).to eql("Test")
        end
        it "will not place a token in a full column" do
            6.times do board.place(6,"Test") end
            expect(board.place(6,"Test")).to eql(false)
        end
    end
    describe "#board_full?" do
        it "returns false if the board is not empty" do
            expect(board.board_full?).to eql(false)
        end
        it "returns true if the board is full" do
            board.instance_variable_set(:@board, (Array.new(6) {Array.new(7) {"Test"}}))
            expect(board.board_full?).to eql(true)
        end
    end
    describe "#horizontal_win?" do
        it "returns false if there is no win detected" do
            board.place(0, 1)
            board.place(1, 1)
            board.place(2, 1)
            board.place(3, 2)
            board.place(4, 1)
            expect(board.horizontal_win?).to eql(false)
        end
        it "returns true if there is a win detected" do
            board.place(0, 1)
            board.place(1, 1)
            board.place(2, 1)
            board.place(3, 1)
            expect(board.horizontal_win?).to eql(true)
        end
    end
    describe "#vertical_win?" do
        it "returns false if there is no win detected" do
            board.place(0, 1)
            board.place(0, 1)
            board.place(0, 1)
            board.place(0, 2)
            board.place(0, 1)
            expect(board.vertical_win?).to eql(false)
        end
        it "returns true if there is a win detected" do
            board.place(0, 1)
            board.place(0, 1)
            board.place(0, 1)
            board.place(0, 1)
            expect(board.vertical_win?).to eql(true)
        end
    end
    describe "#diagonal_win?" do
        it "returns false if there is no win detected" do
            example_board = [
                [nil,nil,nil,nil,nil,nil,nil],
                [nil,nil,nil,nil,nil,nil,nil],
                [nil,nil,2,nil,2,nil,nil],
                [nil,nil,nil,1,nil,nil,nil],
                [nil,nil,1,nil,2,nil,nil],
                [nil,1,nil,nil,nil,2,nil]
            ]
            board.instance_variable_set(:@board, example_board)
            expect(board.vertical_win?).to eql(false)
        end
        it "returns true if there is a win detected" do
            example_board = [
                [nil,nil,nil,nil,nil,nil,nil],
                [nil,nil,nil,nil,nil,nil,nil],
                [nil,nil,2,nil,1,nil,nil],
                [nil,nil,nil,1,nil,nil,nil],
                [nil,nil,1,nil,2,nil,nil],
                [nil,1,nil,nil,nil,2,nil]
            ]
            board.instance_variable_set(:@board, example_board)
            expect(board.vertical_win?).to eql(false)
        end
    end
    describe "#check_state" do
        it "returns :p2 if state is :p1 without win" do
            expect(board.check_state).to eql(:p2)
        end
        it "returns :p1 if state is :p2 without win" do
            board.instance_variable_set(:@state, :p2)
            expect(board.check_state).to eql(:p1)
        end
        it "returns nil if state is nil" do
            board.instance_variable_set(:@state, nil)
            expect(board.check_state).to eql(nil)
        end
        it "returns nil if win is detected" do
            board.place(0, 1)
            board.place(0, 1)
            board.place(0, 1)
            board.place(0, 1)
            expect(board.check_state).to eql(nil)
        end
    end
    describe "#find_token" do
        it "returns placeholder if position is nil" do
            expect(board.find_token(5,0)).to eql("n")
        end
        it "returns token (as string) if position is filled" do
            board.place(0,1)
            expect(board.find_token(5,0)).to eql("1")
        end
    end
    describe "#win?" do
        it "returns true if string contains a winning sequence" do
            expect(board.win?("1111")).to eql(true)
            expect(board.win?("2222")).to eql(true)
        end
        it "returns false if string contains no winning sequence" do
            expect(board.win?("11211")).to eql(false)
            expect(board.win?("22122")).to eql(false)
        end
    end
end
