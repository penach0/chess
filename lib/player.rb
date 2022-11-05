# This class represents a player of a chess game
class Player
  attr_reader :color, :piece

  def initialize(color)
    @color = color
    @piece = create_pieces
  end

  def create_pieces
    Bishop.new('c1', color)
  end

  def place_pieces(board)
    board.set_piece(piece.symbol, piece.position)
  end

  def make_move(board, start_coordinate, end_coordinate)
    board.move_piece(start_coordinate, end_coordinate)
  end
end
