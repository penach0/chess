require_relative '../lib/chess'
include MoveChecker
include Directions

describe MoveChecker do
  describe '#allowed_moves' do
    context 'when the path is completely empty' do
      let(:empty_path_board) { Board.new(board: '7b/8/8/8/8/8/8/8') }

      it 'returns the full path' do
        path = find_paths('h8', diagonals(empty_path_board.board)).flatten
        piece = empty_path_board.piece_in('h8')
        result = allowed_moves(path, piece)

        expect(result).to eq(['g7', 'f6', 'e5', 'd4', 'c3', 'b2', 'a1'])
      end
    end

    context 'when the path is blocked by a same colored piece' do
      let(:same_blocked_board) { Board.new(board: '7b/8/8/4b3/8/8/8/8') }

      it 'returns the path until the first piece excluding it' do
        path = find_paths('h8', diagonals(same_blocked_board.board)).flatten
        piece = same_blocked_board.piece_in('h8')
        result = allowed_moves(path, piece)

        expect(result).to eq(['g7', 'f6'])
      end
    end

    context 'when the path is blocked by a opposite colored piece' do
      let(:opposite_blocked_board) { Board.new(board: '7b/8/8/4B3/8/8/8/8') }

      it 'returns the path until the first piece including it (it allows a capture)' do
        path = find_paths('h8', diagonals(opposite_blocked_board.board)).flatten
        piece = opposite_blocked_board.piece_in('h8')
        result = allowed_moves(path, piece)

        expect(result).to eq(['g7', 'f6', 'e5'])
      end
    end

    context 'when the path there are two paths' do
      let(:two_paths_board) { Board.new(board: '7b/8/2B5/8/4b3/8/8/8') }

      it 'returns coordinates for both paths' do
        paths = find_paths('e4', diagonals(two_paths_board.board))
        piece = two_paths_board.piece_in('e4')
        result = paths.map { |path| allowed_moves(path, piece) }

        expect(result).to eq([['d5', 'c6', 'f3', 'g2', 'h1'],
                              ['f5', 'g6', 'h7', 'd3', 'c2', 'b1']])
      end
    end
  end
end
