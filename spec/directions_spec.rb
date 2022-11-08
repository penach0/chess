require_relative '../lib/directions'
require_relative '../lib/bishop'
require_relative '../lib/board'

describe Directions do
  describe '#diagonals' do
    let(:diagonal_board) { Board.new }
    it 'returns an array containing all diagonals on the board (size > 1)' do
      piece = Bishop.new('c1', 'black')
      diagonals_by_coordinates = piece.diagonals(diagonal_board.board)
                                      .map do |diagonal|
                                        square_coordinates(diagonal).sort
                                      end

      expect(diagonals_by_coordinates).to eq([["a8", "b7", "c6", "d5", "e4", "f3", "g2", "h1"],
                                              ["b8", "c7", "d6", "e5", "f4", "g3", "h2"],
                                              ["c8", "d7", "e6", "f5", "g4", "h3"],
                                              ["d8", "e7", "f6", "g5", "h4"],
                                              ["e8", "f7", "g6", "h5"],
                                              ["f8", "g7", "h6"],
                                              ["g8", "h7"],
                                              ["a7", "b6", "c5", "d4", "e3", "f2", "g1"],
                                              ["a6", "b5", "c4", "d3", "e2", "f1"],
                                              ["a5", "b4", "c3", "d2", "e1"],
                                              ["a4", "b3", "c2", "d1"],
                                              ["a3", "b2", "c1"],
                                              ["a2", "b1"],
                                              ["a1", "b2", "c3", "d4", "e5", "f6", "g7", "h8"],
                                              ["b1", "c2", "d3", "e4", "f5", "g6", "h7"],
                                              ["c1", "d2", "e3", "f4", "g5", "h6"],
                                              ["d1", "e2", "f3", "g4", "h5"],
                                              ["e1", "f2", "g3", "h4"],
                                              ["f1", "g2", "h3"],
                                              ["g1", "h2"],
                                              ["a2", "b3", "c4", "d5", "e6", "f7", "g8"],
                                              ["a3", "b4", "c5", "d6", "e7", "f8"],
                                              ["a4", "b5", "c6", "d7", "e8"],
                                              ["a5", "b6", "c7", "d8"],
                                              ["a6", "b7", "c8"],
                                              ["a7", "b8"]])
    end
  end
end

def square_coordinates(array)
  array.map(&:coordinate)
end
