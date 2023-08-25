require_relative '../lib/chess'

describe Piece do
  let(:piece_board) { Board.new(fen: '7b/6n1/2B5/8/1k2b3/8/8/5K2') }

  describe '#update_position' do
    subject(:update_piece) { described_class.for(Coordinate.from_string('a1'), Helpers::BLACK_PIECE_FEN) }

    it 'updates the position attribute of a piece' do
      new_position = Coordinate.from_string('b1')
      update_piece.update_position(new_position)
      updated_position = update_piece.position

      expect(updated_position).to eq(new_position)
    end
  end

  describe '#possible_moves' do
    it 'returns an array of all the possible moves coordinates' do
      piece = piece_board.piece_in(Coordinate.from_string('e4'))
      possible_moves = piece.possible_moves(piece_board)
      result = algebraic_from_squares(possible_moves)

      expect(result).to contain_exactly('d5', 'c6', 'f3', 'g2', 'h1', 'f5',
                                        'g6', 'h7', 'd3', 'c2', 'b1')
    end
  end

  describe '#movable?' do
    it 'returns true if the piece is movable' do
      movable_piece = piece_board.piece_in(Coordinate.from_string('c6'))

      expect(movable_piece).to be_movable(piece_board)
    end

    it 'returns false if the piece is not movable' do
      unmovable_piece = piece_board.piece_in(Coordinate.from_string('h8'))

      expect(unmovable_piece).not_to be_movable(piece_board)
    end
  end

  describe '#nil?' do
    subject(:null_piece) { described_class.for(Coordinate.from_string('g1'), Helpers::NO_PIECE_FEN) }
    let(:normal_piece) { described_class.for(Coordinate.from_string('a1'), Helpers::BLACK_PIECE_FEN) }

    it 'returns false if a piece is not null' do
      expect(normal_piece).not_to be_nil
    end

    it 'returns true if a piece is null' do
      expect(null_piece).to be_nil
    end
  end
end
