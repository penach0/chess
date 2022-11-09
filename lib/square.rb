require_relative 'coordinates'

# Represents a square on the board
class Square
  include Coordinates
  WHITE_PIECES = [' ♔ ', ' ♕ ', ' ♖ ', ' ♗ ', ' ♘ ', ' ♙ '].freeze
  BLACK_PIECES = [' ♚ ', ' ♛ ', ' ♜ ', ' ♝ ', ' ♞ ', ' ♟︎ '].freeze

  attr_reader :coordinate
  attr_accessor :content

  def initialize(content, row, column)
    @content = content
    @coordinate = array_to_algebraic(row, column)
    @color = color(row, column)
  end

  def update(content)
    self.content = content
  end

  def clear
    self.content = '   '
  end

  def empty?
    content == '   '
  end

  def occupied?(piece_color: nil)
    case piece_color
    when 'white'
      return WHITE_PIECES.include?(content)
    when 'black'
      return BLACK_PIECES.include?(content)
    end

    !empty?
  end

  def color(row, column)
    coordinate_sum = row + column
    coordinate_sum.even? ? 'light' : 'dark'
  end

  def dark_square(content)
    "\e[1;48;5;179m#{content}\e[0m"
  end

  def light_square(content)
    "\e[1;48;5;229m#{content}\e[0m"
  end

  def to_s
    @color == 'light' ? light_square(content) : dark_square(content)
  end
end
