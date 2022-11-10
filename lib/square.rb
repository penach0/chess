require_relative 'coordinates'

# Represents a square on the board
class Square
  include Coordinates
  attr_reader :coordinate
  attr_accessor :piece

  def self.color(row, column)
    coordinate_sum = row + column
    coordinate_sum.even? ? 'light' : 'dark'
  end

  def initialize(piece, coordinate, color)
    @piece = Piece.for(piece, coordinate)
    @coordinate = coordinate
    @color = color
  end

  def update(piece)
    self.piece.captured
    self.piece = piece
    piece.update_position(coordinate)
  end

  def clear
    self.piece = NoPiece.new(coordinate, nil)
  end

  def empty?
    piece.null?
  end

  def occupied?(piece_color = nil)
    return false if empty?
    return !empty? unless piece_color

    piece.color == piece_color
  end

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
