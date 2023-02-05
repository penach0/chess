# This class finds and builds paths available for a piece given
# its position and movement
class Path
  attr_reader :path, :piece

  def initialize(board, coordinate, direction, steps: board.size)
    @path = board.path_in_direction(coordinate, direction, steps:)
    @piece = board.piece_in(coordinate)
  end

  def piece_scope
    return path if empty?

    path[0, blocking_piece_index + 1]
  end

  def free_squares
    return self if empty?

    @path = path[0, blocking_piece_index]

    self
  end

  def blocking_piece_index
    path.index(&:occupied?)
  end

  def empty?
    path.all?(&:empty?)
  end
end
