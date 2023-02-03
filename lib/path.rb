# This class finds and builds paths available for a piece given
# its position and movement
class Path
  attr_reader :path

  def initialize(board, coordinate, direction, steps: nil)
    @path = board.path_in_direction(coordinate, direction)
  end
end