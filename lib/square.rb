require_relative 'coordinates'

# Represents a square on the board
class Square
  include Coordinates
  attr_reader :coordinate
  attr_accessor :content

  def self.color(row, column)
    coordinate_sum = row + column
    coordinate_sum.even? ? 'light' : 'dark'
  end

  def initialize(content, coordinate, color)
    @content = Piece.for(content, coordinate)
    @coordinate = coordinate
    @color = color
  end

  def piece
    content unless empty?
  end

  def update(content)
    self.content.captured unless empty?
    self.content = content
    content.update_position(coordinate)
  end

  def clear
    self.content = '   '
  end

  def empty?
    content == '   '
  end

  def occupied?(piece_color = nil)
    return false if empty?
    return !empty? unless piece_color

    content.color == piece_color
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
