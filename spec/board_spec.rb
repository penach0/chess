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

      expect(piece).to be_a(Bishop).and have_attributes(color: 'black')
    end
  end

  describe '#pieces' do
    subject(:pieces_board) { described_class.new(fen: '2b2b2/8/7b/8/8/8/B7/2B2B2') }

    it 'fetches the white pieces' do
      white_pieces = pieces_board.pieces('white')

      expect(white_pieces).to contain_exactly(Piece.for(Coordinate.new(algebraic: 'a2'), 'B'),
                                              Piece.for(Coordinate.new(algebraic: 'c1'), 'B'),
                                              Piece.for(Coordinate.new(algebraic: 'f1'), 'B'))
    end

    it 'fetches the black pieces' do
      black_pieces = pieces_board.pieces('black')

      expect(black_pieces).to contain_exactly(Piece.for(Coordinate.new(algebraic: 'c8'), 'b'),
                                              Piece.for(Coordinate.new(algebraic: 'f8'), 'b'),
                                              Piece.for(Coordinate.new(algebraic: 'h6'), 'b'))
    end

    it 'fetches the all pieces when no color is given' do
      all_pieces = pieces_board.pieces

      expect(all_pieces).to contain_exactly(Piece.for(Coordinate.new(algebraic: 'a2'), 'B'),
                                            Piece.for(Coordinate.new(algebraic: 'c1'), 'B'),
                                            Piece.for(Coordinate.new(algebraic: 'f1'), 'B'),
                                            Piece.for(Coordinate.new(algebraic: 'c8'), 'b'),
                                            Piece.for(Coordinate.new(algebraic: 'f8'), 'b'),
                                            Piece.for(Coordinate.new(algebraic: 'h6'), 'b'))
    end
  end

  describe '#squares_atacked_by' do
    subject(:attacked_board) { described_class.new(fen: '8/8/8/8/3P1b2/4B1p1/8/8') }

    it 'fetches the squares attacked by white' do
      attacked_squares = attacked_board.squares_attacked_by('white')
      coordinates = attacked_squares.map(&:coordinate)

      expect(coordinates).to contain_exactly(Coordinate.new(algebraic: 'c1'), Coordinate.new(algebraic: 'd2'),
                                             Coordinate.new(algebraic: 'f4'), Coordinate.new(algebraic: 'f2'),
                                             Coordinate.new(algebraic: 'g1'), Coordinate.new(algebraic: 'd4'),
                                             Coordinate.new(algebraic: 'e5'), Coordinate.new(algebraic: 'c5'))
    end

    it 'fetches the squares attacked by black' do
      attacked_squares = attacked_board.squares_attacked_by('black')
      coordinates = attacked_squares.map(&:coordinate)

      expect(coordinates).to contain_exactly(Coordinate.new(algebraic: 'b8'), Coordinate.new(algebraic: 'c7'),
                                             Coordinate.new(algebraic: 'd6'), Coordinate.new(algebraic: 'e5'),
                                             Coordinate.new(algebraic: 'g3'), Coordinate.new(algebraic: 'h2'),
                                             Coordinate.new(algebraic: 'g5'), Coordinate.new(algebraic: 'h6'),
                                             Coordinate.new(algebraic: 'e3'), Coordinate.new(algebraic: 'f2'))
    end
  end

  describe '#move_piece' do
    subject(:move_board) { described_class.new(fen: '8/8/8/8/8/8/8/2b5') }

    it 'moves a piece' do
      start_coordinate = 'c1'
      end_coordinate = 'h6'
      move_board.move_piece(Move.new(start_coordinate, end_coordinate))
      result_board = BoardDecoder.decode(move_board.board)

      expect(result_board).to eq('8/8/7b/8/8/8/8/8')
    end
  end
end
