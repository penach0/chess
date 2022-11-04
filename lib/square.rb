require_relative 'coordinates'

# Represents a square on the board
class Square
  include Coordinates
  attr_reader :coordinate
  attr_accessor :piece

  def self.squarify(element, row, column)
    new(element, row, column)
  end

  def initialize(piece, row, column)
    @piece = piece
    @coordinate = array_to_algebraic(row, column)
    @color = color(row, column)
  end

  def update(piece)
    self.piece = piece
  end

  def clear
    self.piece = '   '
  end

  def occupied?
    piece != '   '
  end

  def color(row, column)
    coordinate_sum = row + column
    coordinate_sum.even? ? 'light' : 'dark'
  end

  def dark_square(piece)
    "\e[1;48;5;94m#{piece}\e[0m"
  end

  def light_square(piece)
    "\e[1;48;5;179m#{piece}\e[0m"
  end

  def to_s
    @color == 'light' ? light_square(piece) : dark_square(piece)
  end
end
