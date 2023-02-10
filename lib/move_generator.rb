require_relative 'chess'
# This class will generate all available moves given a starting coordinate
class MoveGenerator
  attr_reader :board, :coordinate

  def initialize(board, coordinate)
    @board = board
    @coordinate = coordinate
  end

  def moves
    possible_destinations.map { |destination| Move.new(coordinate, destination) }
  end

  def possible_destinations
    paths.map(&:piece_scope).flatten
  end

  def paths
    piece.available_paths(board)
  end

  def piece
    board.piece_in(coordinate)
  end
end
