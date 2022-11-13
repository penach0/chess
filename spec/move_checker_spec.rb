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

    context 'when the path there are two paths' do

    end
  end
end
