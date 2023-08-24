require_relative 'chess'
# Represents a square on the board
class Square
  attr_reader :coordinate, :color
  attr_accessor :piece

  def self.color(row, column)
    coordinate_sum = row + column
    coordinate_sum.even? ? 'light' : 'dark'
  end

  def initialize(row, column, fen)
    @coordinate = Coordinate.new(row:, column:)
    @piece = Piece.for(@coordinate, fen)
    @color = Square.color(row, column)
  end

  def update(piece)
    self.piece = piece

    piece.update_position(coordinate)
  end

  def clear
    self.piece = NoPiece.new(coordinate, ' ')
  end

  def empty?
    piece.nil?
  end

  def occupied?(piece_color = nil)
    return false if empty?
    return !empty? unless piece_color

    piece.color == piece_color
  end

  def row
    coordinate.row
  end

  def column
    coordinate.column
  end

  def algebraic
    coordinate.to_s
  end

  def ==(other)
    self.class == other.class &&
      coordinate == other.coordinate && piece.fen_value == other.piece.fen_value
  end

  private

  def dark_square(piece)
    "\e[1;48;5;179m#{piece}\e[0m"
  end

  def light_square(piece)
    "\e[1;48;5;229m#{piece}\e[0m"
  end

  def to_s
    @color == 'light' ? light_square(piece) : dark_square(piece)
  end
end
