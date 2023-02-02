require_relative 'chess'
# Represents a Chessboard
class Board
  include BoardDecoder
  attr_reader :board

  SIZE = 8

  CASTLING_POSSIBILITIES = {['e1', 'g1'] => ['h1', 'f1'],
                            ['e1', 'c1'] => ['a1', 'd1'],
                            ['e8', 'g8'] => ['h8', 'f8'],
                            ['e8', 'c8'] => ['a8', 'd8']}.freeze

  def self.inside_board?(coordinate)
    [coordinate.row, coordinate.column].all? { |el| el.between?(0, SIZE - 1) }
  end

  def initialize(fen: '8/8/8/8/8/8/8/8')
    @board = BoardBuilder.build(fen)
  end

  def square(coordinate)
    row, column = Coordinate.to_array(coordinate)

    board[row][column]
  end

  def piece_in(coordinate)
    square(coordinate).piece
  end

  def pieces(color = nil)
    board.flatten
         .filter_map { |square| square.piece if square.occupied?(color) }
  end

  def squares_attacked_by(color)
    pieces(color).map { |piece| piece.attacking(self) }
                 .flatten
                 .uniq
  end

  def clone
    fen_string = fen_string(board)

    Board.new(fen: fen_string)
  end

  def in_check?(color)
    pieces(color).find { |piece| piece.is_a?(King) }
                 .in_check?(self)
  end

  def castle(start_coordinate, end_coordinate)
    castling_direction = [start_coordinate, end_coordinate]
    move_piece(start_coordinate, end_coordinate)

    rook_start, rook_end = CASTLING_POSSIBILITIES[castling_direction]
    move_piece(rook_start, rook_end)
  end

  def move_piece(start_coordinate, end_coordinate)
    stored_piece = piece_in(start_coordinate)

    remove_piece(start_coordinate)
    place_piece(stored_piece, end_coordinate)
  end

  def find_single_moves(position, directions)
    directions.map { |direction| single_move(position, direction) }.compact
  end

  def find_paths(position, directions)
    directions.map { |direction| path_in_direction(position, direction) }
              .delete_if(&:empty?)
  end

  def path_in_direction(position, direction)
    coordinate = position.traverse(direction)
    path = []
    while Board.inside_board?(coordinate)
      path << square(coordinate)
      coordinate = coordinate.traverse(direction)
    end
    path
  end

  private

  def place_piece(piece, end_coordinate)
    square(end_coordinate).update(piece)
  end

  def remove_piece(coordinate)
    square(coordinate).clear
  end

  def single_move(position, direction)
    coordinate = position.traverse(direction)

    square(coordinate) if Board.inside_board?(coordinate)
  end

  def to_s
    board.each_with_index.reduce('') do |string, (line, index)|
      line_number = SIZE - index
      string + "#{line_number} #{line.join} #{line_number}\n"
    end
  end
end
