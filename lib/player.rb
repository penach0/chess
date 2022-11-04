# This class represents a player of a chess game
class Player
  attr_reader :color, :piece

  def initialize(color)
    @color = color
    @piece = create_pieces
  end

  def create_pieces
    Bishop.new('c2', color)
  end

  def set_pieces(board)
    board.set_piece(piece.symbol, piece.position)
  end
end
