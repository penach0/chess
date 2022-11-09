require_relative 'move'
# This class represents a player of a chess game
class Player
  attr_reader :color, :piece

  def initialize(color)
    @color = color
    @piece = create_pieces
  end

  def create_pieces
    if color == 'black'
      Bishop.new('f8', color)
    else
      Bishop.new('c1', color)
    end
  end

  def place_pieces(board)
    board.place_piece(piece)
  end

  def make_move(board, start_coordinate, end_coordinate)
    # Move.new(board, self).execute
    board.move_piece(start_coordinate, end_coordinate)
    piece.update_position(end_coordinate)
  end
end
