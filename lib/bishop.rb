require_relative 'piece'

# This class represents a bishop chess piece
class Bishop
  include Coordinates
  attr_reader :position, :symbol

  def initialize(position, color)
    @position = position
    @symbol = (color == 'white' ? ' ♗ ' : ' ♝ ')
  end

  def move(new_position)
    @position = new_position
  end
end
