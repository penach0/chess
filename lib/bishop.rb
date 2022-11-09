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

  def available_paths(board)
    diagonals(board.board).find_all do |diagonal|
      find_diagonals(diagonal)
    end
  end

  def can_move?(board)
    !possible_moves(board).empty?
  end

  def update_position(new_position)
    @position = new_position
  end
end
