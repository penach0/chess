require_relative 'chess'
# This class describes an array of paths available to a piece
class Paths
  attr_accessor :board, :coordinate, :paths

  def initialize(board, coordinate)
    @board = board
    @coordinate = coordinate
    @paths = find_paths
  end

  def find_paths
    piece.directions
         .map { |direction| Path.new(board, coordinate, direction, steps: piece.steps) }
  end

  def possible_destinations
    paths.map(&:piece_scope)
  end

  def piece
    board.piece_in(coordinate)
  end
end
