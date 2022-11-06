require_relative '../lib/board'

describe Board do
  describe '#move_piece' do
    subject(:move_board) do
      described_class.new(board: [['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                                  ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                                  ['   ', '   ', ' ♗ ', '   ', '   ', '   ', '   ', '   ']])
    end

    it 'moves a piece' do
      start_coordinate = 'c1'
      end_coordinate = 'h6'
      move_board.move_piece(start_coordinate, end_coordinate)
      board = unsquarify_board(move_board.board)

      expect(board).to eq([['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                           ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                           ['   ', '   ', '   ', '   ', '   ', '   ', '   ', ' ♗ '],
                           ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                           ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                           ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                           ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   '],
                           ['   ', '   ', '   ', '   ', '   ', '   ', '   ', '   ']])
    end
  end
end

def unsquarify_board(board)
  board.map do |line|
    line.map(&:piece)
  end
end
