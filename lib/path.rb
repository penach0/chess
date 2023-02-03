# This class finds and builds paths available for a piece given
# its position and movement
class Path
  attr_reader :path, :piece

  def initialize(board, coordinate, direction, steps: nil)
    @path = board.path_in_direction(coordinate, direction)
    @piece = board.piece_in(coordinate)
  end

  def piece_scope
    return path if path_empty?(path)

    path[0, blocking_piece_index(path) + 1]
  end

  def blocking_piece_index
    path.index(&:occupied?)
  end

  def empty?
    path.all?(&:empty?)
  end
end