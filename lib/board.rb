# Represents a Chessboard
class Board
  def initialize(board = nil)
    @board = board || Array.new(8) { Array.new(8) }
  end
end
