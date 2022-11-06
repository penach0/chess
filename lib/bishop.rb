require_relative 'piece'

# This class represents a bishop chess piece
class Bishop
  include Coordinates
  attr_reader :symbol, :position

  def initialize(position, color)
    @position = position
    @symbol = (color == 'white' ? ' ♗ ' : ' ♝ ')
  end

  def possible_moves

  end

  def update_position(new_position)
    @position = new_position
  end
end
