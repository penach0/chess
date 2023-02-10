require_relative 'chess'
# This class will generate all available moves given a starting coordinate
class MoveGenerator
  def initialize(board, coordinate)
    @board = board
    @coordinate = coordinate
  end
end