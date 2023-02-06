require_relative 'chess'
# Represents a Chessboard
class Board
  include BoardDecoder
  attr_reader :board, :size

  SIZE = 8

  def self.inside_board?(coordinate)
    [coordinate.row, coordinate.column].all? { |el| el.between?(0, SIZE - 1) }
  end

  def initialize(fen: '8/8/8/8/8/8/8/8')
    @board = BoardBuilder.build(fen)
    @size = SIZE
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
    fen_string = board_fen_string(board)

    Board.new(fen: fen_string)
  end

  def in_check?(color)
    pieces(color).find { |piece| piece.is_a?(King) }
                 .in_check?(self)
  end

  def move_piece(start_coordinate, end_coordinate)
    stored_piece = piece_in(start_coordinate)

    remove_piece(start_coordinate)
    place_piece(stored_piece, end_coordinate)
  end

  def path_in_direction(position, direction, steps: SIZE)
    coordinate = position.traverse(direction)
    path = []

    while path.size < steps && Board.inside_board?(coordinate)
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

  def to_s
    board.each_with_index.reduce('') do |string, (line, index)|
      line_number = SIZE - index
      string + "#{line_number} #{line.join} #{line_number}\n"
    end
  end
end
