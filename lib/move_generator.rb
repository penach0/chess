require_relative 'chess'
# This class will generate all available moves given a starting coordinate
class MoveGenerator
  attr_reader :board, :coordinate

  def initialize(board, coordinate)
    @board = board
    @coordinate = coordinate
  end

  def legal_moves
    moves.select { |move| legal?(move) }
  end

  def moves
    possible_destinations = paths.possible_destinations
                                 .flatten

    possible_destinations.map { |destination| Move.new(coordinate, destination.coordinate) }
  end

  def legal?(move)
    piece_in_landing = board.piece_in(move.to)

    piece.can_capture?(piece_in_landing) && !moves_into_check?(move)
  end

  def moves_into_check?(move)
    board_dup = board.clone

    board_dup.move_piece(move)

    board_dup.in_check?(piece.color)
  end

  def paths
    PathFactory.create_paths(board, coordinate, piece)
  end

  def piece
    board.piece_in(coordinate)
  end
end
