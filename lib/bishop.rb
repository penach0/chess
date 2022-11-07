require_relative 'piece'
require_relative 'directions'

# This class represents a bishop chess piece
class Bishop
  include Directions
  attr_reader :symbol
  attr_accessor :position

  def initialize(position, color)
    @position = position
    @symbol = (color == 'white' ? ' ♗ ' : ' ♝ ')
  end

  def possible_moves(board)
    diagonals(board.board).find_all do |diagonal|
      find_diagonals(diagonal)
    end
  end

  def find_diagonals(diagonal)
    diagonal.find { |square| square.coordinate == position }
  end

  def update_position(new_position)
    @position = new_position
  end
end
