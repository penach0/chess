require_relative '../lib/chess'

describe Board do
  describe '#inside_board?' do
    context 'with a 8x8 board' do
      subject(:coordinate_board) { described_class.new(fen: '8/8/8/8/8/8/8/8') }
      it 'returns true when inside the board' do
        coordinate = Coordinate.from_string('f4')

        expect(coordinate_board).to be_inside_board(coordinate)
      end

      it 'returns false when outside the board' do
        coordinate = Coordinate.from_string('c9')

        expect(coordinate_board).not_to be_inside_board(coordinate)
      end
    end

    context 'with a 10x10 board' do
      subject(:large_board) { described_class.new(fen: '8/8/8/8/8/8/8/8/8/8') }
      it 'returns true when inside the board' do
        coordinate = Coordinate.from_string('c9', board_size: large_board.size)

        expect(large_board).to be_inside_board(coordinate)
      end

      it 'returns false when outside the board' do
        coordinate = Coordinate.from_string('p12', board_size: large_board.size)

        expect(large_board).not_to be_inside_board(coordinate)
      end
    end
  end

  describe '#square' do
    subject(:square_board) { described_class.new(fen: '8/8/8/8/8/8/8/2b5') }

    it 'returns the correct square' do
      coordinate = Coordinate.from_string('c1')
      square = square_board.square(coordinate)
      piece_in_square = square.piece

      expect(square).to be_a(Square).and have_attributes(color: 'dark')
      expect(piece_in_square).to be_a(Bishop).and have_attributes(color: 'black')
    end
  end

  describe '#piece_in' do
    subject(:piece_board) { described_class.new(fen: '8/8/8/8/8/8/8/2b5') }

    it 'returns the piece in the given square' do
      coordinate = Coordinate.from_string('c1')
      piece = piece_board.piece_in(coordinate)

      expect(piece).to be_a(Bishop).and have_attributes(color: 'black')
    end
  end

  describe '#pieces' do
    subject(:pieces_board) { described_class.new(fen: '2b2b2/8/7b/8/8/8/B7/2B2B2') }

    it 'fetches the white pieces' do
      white_pieces = pieces_board.pieces('white')

      expect(white_pieces).to contain_exactly(Piece.for(Coordinate.from_string('a2'), 'B'),
                                              Piece.for(Coordinate.from_string('c1'), 'B'),
                                              Piece.for(Coordinate.from_string('f1'), 'B'))
    end

    it 'fetches the black pieces' do
      black_pieces = pieces_board.pieces('black')

      expect(black_pieces).to contain_exactly(Piece.for(Coordinate.from_string('c8'), 'b'),
                                              Piece.for(Coordinate.from_string('f8'), 'b'),
                                              Piece.for(Coordinate.from_string('h6'), 'b'))
    end

    it 'fetches the all pieces when no color is given' do
      all_pieces = pieces_board.pieces

      expect(all_pieces).to contain_exactly(Piece.for(Coordinate.from_string('a2'), 'B'),
                                            Piece.for(Coordinate.from_string('c1'), 'B'),
                                            Piece.for(Coordinate.from_string('f1'), 'B'),
                                            Piece.for(Coordinate.from_string('c8'), 'b'),
                                            Piece.for(Coordinate.from_string('f8'), 'b'),
                                            Piece.for(Coordinate.from_string('h6'), 'b'))
    end
  end

  describe '#squares_atacked_by' do
    subject(:attacked_board) { described_class.new(fen: '8/8/8/8/3P1b2/4B1p1/8/8') }

    it 'fetches the squares attacked by white' do
      attacked_squares = attacked_board.squares_attacked_by('white')
      algebraic_coordinates = algebraic_from_squares(attacked_squares)

      expect(algebraic_coordinates).to contain_exactly('c1', 'd2', 'f4', 'f2', 'g1', 'd4', 'e5', 'c5')
    end

    it 'fetches the squares attacked by black' do
      attacked_squares = attacked_board.squares_attacked_by('black')
      algebraic_coordinates = algebraic_from_squares(attacked_squares)

      expect(algebraic_coordinates).to contain_exactly('b8', 'c7', 'd6', 'e5', 'g3', 'h2', 'g5', 'h6', 'e3', 'f2')
    end
  end

  describe '#move_piece' do
    subject(:move_board) { described_class.new(fen: '8/8/8/8/8/8/8/2b5') }

    it 'moves a piece' do
      start_coordinate = Coordinate.from_string('c1')
      end_coordinate = Coordinate.from_string('h6')
      move_board.move_piece(Move.new(start_coordinate, end_coordinate))
      result_board = BoardDecoder.decode(move_board.board)

      expect(result_board).to eq('8/8/7b/8/8/8/8/8')
    end
  end

  describe '#in_check?' do
    subject(:checked_board) { described_class.new(fen: 'rnbqkb1r/ppp1pppp/5n2/3p4/Q1P5/5N2/PP1PPPPP/RNB1KB1R') }

    it 'identifies a position in check' do
      player_in_check = 'black'

      expect(checked_board).to be_in_check(player_in_check)
    end

    it 'identifies a position not in check' do
      player_not_in_check = 'white'

      expect(checked_board).not_to be_in_check(player_not_in_check)
    end
  end

  describe '#path_in_direction' do
    subject(:path_board) { described_class.new(fen: '8/8/8/6p1/3P1b2/4B3/8/8') }

    context 'when finding full paths' do
      steps = Float::INFINITY
      starting_position = Coordinate.from_string('f4')

      it 'fetches empty path' do
        direction = Piece::DIAGONAL[:up_left]
        path = path_board.path_in_direction(starting_position, direction, steps:)
        result = algebraic_from_squares(path)

        expect(result).to contain_exactly('b8', 'c7', 'd6', 'e5')
      end

      it 'fetches path even if blocked' do
        direction = Piece::DIAGONAL[:down_left]
        path = path_board.path_in_direction(starting_position, direction, steps:)
        result = algebraic_from_squares(path)

        expect(result).to contain_exactly('e3', 'd2', 'c1')
      end
    end

    context 'when finding partial paths' do
      steps = 1
      starting_position = Coordinate.from_string('g5')

      it 'fetches empty path' do
        direction = Piece::DIAGONAL[:down_right]
        path = path_board.path_in_direction(starting_position, direction, steps:)
        result = algebraic_from_squares(path)

        expect(result).to contain_exactly('h4')
      end

      it 'fetches path even if blocked' do
        direction = Piece::DIAGONAL[:down_left]
        path = path_board.path_in_direction(starting_position, direction, steps:)
        result = algebraic_from_squares(path)

        expect(result).to contain_exactly('f4')
      end
    end
  end
end

def algebraic_from_squares(squares)
  squares.map(&:algebraic)
end
