require_relative '../lib/chess'

describe Board do
  describe '#square' do
    subject(:square_board) { described_class.new(fen: '8/8/8/8/8/8/8/2b5') }

    it 'returns the correct square' do
      coordinate = 'c1'
      square = square_board.square(coordinate)
      piece_in_square = square.piece

      expect(square).to be_a(Square).and have_attributes(color: 'dark')
      expect(piece_in_square).to be_a(Bishop).and have_attributes(color: 'black')
    end
  end

  describe '#piece_in' do
    subject(:piece_board) { described_class.new(fen: '8/8/8/8/8/8/8/2b5') }

    it 'returns the piece in the given square' do
      coordinate = 'c1'
      piece = piece_board.piece_in(coordinate)

      expect(piece.symbol).to eq(' ♝ ')
      expect(piece.color).to eq('black')
    end
  end

  describe '#pieces_of_color' do
    subject(:pieces_board) { described_class.new(fen: '2b2b2/8/7b/8/8/8/B7/2B2B2') }

    it 'fetches the pieces of the passed color' do
      white_pieces = pieces_board.pieces_of_color('white')
      piece_coordinates = white_pieces.map(&:position)

      expect(piece_coordinates).to eq(['a2', 'c1', 'f1'])
    end
  end

  describe '#move_piece' do
    subject(:move_board) { described_class.new(fen: '8/8/8/8/8/8/8/2b5') }

    it 'moves a piece' do
      start_coordinate = 'c1'
      end_coordinate = 'h6'
      move_board.move_piece(start_coordinate, end_coordinate)
      result_board = fen_string(move_board.board)

      expect(result_board).to eq('8/8/7b/8/8/8/8/8')
    end
  end
end
