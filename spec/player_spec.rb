require ("./lib/board.rb")
require ("./lib/player.rb")

describe User do
    let(:board) { Board.new }
    subject(:player) { described_class.new(board, 1) }

    describe "#turn" do
        it "allows user to make a turn" do
            allow(player).to receive(:gets).and_return("1")
            player.turn
            expect(board.board[5][0]).to eql(1)
        end
        it "refuses user to enter values not between 1 - 7" do
            allow(player).to receive(:gets).and_return("0", "8", "E", "1")
            player.turn
            expect(board.board[5][0]).to eql(1)
        end
        it "refuses user to make a turn if column full" do
            6.times do board.place(0,"Test") end
            allow(player).to receive(:gets).and_return("1","2")
            player.turn
            expect(board.board[5][1]).to eql(1)
        end
    end
end

describe Computer do
    let(:board) { Board.new }
    subject(:player) { described_class.new(board, 1) }

    describe "#turn" do
        it "allows computer to make a turn" do
            player.turn
            expect(board.state).to eql(:p2)
        end
    end
end