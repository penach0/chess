require_relative 'piece'
require_relative 'directions'
require_relative 'move_checker'

# This class represents a bishop chess piece
class Bishop < Piece
  include Directions
  include MoveChecker
  attr_reader :color, :symbol, :position

  def initialize(position, color)
    super
    @symbol = (color == 'white' ? ' ♗ ' : ' ♝ ')
  end

  def available_paths(board)
    diagonals(board.board).find_all do |diagonal|
      find_diagonals(diagonal)
    end
  end
end
