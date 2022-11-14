require_relative '../lib/chess'

describe Piece do
  let(:piece_board) { Board.new(board: '7b/8/2B5/8/4b3/8/8/8') }

  describe '#update_position' do
    it 'updates the position attribute of a piece' do
      piece = piece_board.piece_in('e4')
      new_position = 'b1'
      piece.update_position(new_position)
      updated_position = piece.position

      expect(updated_position).to eq(new_position)
    end
  end

  describe '#possible_moves' do
    it 'returns an array of all the possible moves coordinates' do
      piece = piece_board.piece_in('e4')
      possible_moves = piece.possible_moves(piece_board)

      expect(possible_moves).to eq(['d5', 'c6', 'f3', 'g2', 'h1', 'f5',
                                    'g6', 'h7', 'd3', 'c2', 'b1'])
    end
  end

  describe '#movable?' do
    let(:movable_board) { Board.new(board: '7b/6b1/2B5/8/8/8/8/8') }

    it 'returns true if the piece is movable' do
      movable_piece = movable_board.piece_in('c6')

      expect(movable_piece).to be_movable(movable_board)
    end

    it 'returns false if the piece is not movable' do
      unmovable_piece = movable_board.piece_in('h8')

      expect(unmovable_piece).not_to be_movable(movable_board)
    end
  end

  describe '#same_color?' do
    let(:black_piece) { piece_board.piece_in('h8') }

    it 'returns true if both pieces are the same color' do 
      same_color_piece = piece_board.piece_in('e4')

      expect(black_piece).to be_same_color(same_color_piece)
    end

    it 'returns false if the pieces are of different color' do
      different_color_piece = piece_board.piece_in('c6')

      expect(black_piece).not_to be_same_color(different_color_piece)
    end
  end

  describe '#null?' do
    it 'returns false if a piece is not null' do
      normal_piece = piece_board.piece_in('h8')

      expect(normal_piece).not_to be_null
    end

    it 'returns falss if a piece is null' do
      null_piece = piece_board.piece_in('a1')

      expect(null_piece).to be_null
    end

  end

  describe '#captured' do
    it 'sets a piece position to nil' do
      piece = piece_board.piece_in('h8')
      piece.captured

      result = piece.position

      expect(result).to be_nil
    end
  end
end
